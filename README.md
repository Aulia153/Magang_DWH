# Desa Data Warehouse Sync

Sistem sinkronisasi data terpusat berbasis **webhook** dan **event-driven architecture**, yang menghubungkan basis data pada masing-masing website desa (produsen data) dengan sebuah basis data pusat/induk (data warehouse). Setiap perubahan data (`INSERT`, `UPDATE`, `DELETE`) pada tabel yang dipantau di database desa akan terdeteksi secara otomatis melalui _database trigger_, dikirimkan ke server pusat melalui HTTP webhook, dan disimpan ke dalam tabel warehouse yang telah dipetakan — tanpa perlu proses migrasi data manual atau replikasi database penuh.

Project ini terdiri dari tiga komponen independen yang saling terhubung:

| Komponen           | Peran                                                                                                 | Lokasi            |
| ------------------ | ----------------------------------------------------------------------------------------------------- | ----------------- |
| **Sender**         | Worker yang berjalan di tiap desa, memantau antrian perubahan data dan mengirimkannya ke server pusat | `sender/`         |
| **Receiver**       | REST API di server pusat yang menerima, memvalidasi, dan menyimpan data ke warehouse                  | `receiver/`       |
| **Monitoring Web** | Dashboard untuk memantau riwayat sinkronisasi secara real-time                                        | `monitoring_web/` |

---

Sistem dirancang dengan pendekatan **event-driven** menggunakan _database trigger_ untuk mendeteksi perubahan data secara langsung pada saat terjadi, tanpa memerlukan modifikasi struktur tabel utama pada sistem desa maupun proses polling berkala terhadap seluruh baris data.

---

## Fitur Utama

- **Sinkronisasi real-time** — perubahan data pada desa terkirim ke pusat dalam hitungan detik melalui mekanisme antrian dan worker.
- **Distributed queue per desa** — setiap desa memiliki tabel antrian independen, sehingga kegagalan pada satu desa tidak memengaruhi desa lain (tidak ada _single point of failure_).
- **Audit trail lengkap** — seluruh riwayat perubahan data (termasuk nilai sebelum dan sesudah perubahan untuk aksi `UPDATE`) tercatat di `webhook_logs`.
- **Autentikasi per desa** — setiap desa diidentifikasi melalui token API unik, bukan kredensial bersama.
- **Pengecualian data sensitif** — kolom sensitif (misalnya kata sandi dan session token pengguna) dikecualikan sejak level trigger, tidak pernah dikirim keluar dari database desa.
- **Dashboard monitoring** — antarmuka web untuk memantau seluruh riwayat sinkronisasi, dengan filter per desa, per tabel, per jenis aksi, serta pembaruan otomatis.

---

## Teknologi yang Digunakan

**Backend (Sender & Receiver)**

- Node.js
- Express.js
- MySQL (mysql2/promise)
- Axios

**Frontend (Monitoring Web)**

- React + Vite
- React Router DOM
- Tailwind CSS
- Axios

**Database**

- MySQL / MariaDB (trigger, JSON functions)

---

## Struktur Folder

```
desa-data-warehouse-sync/
├── sender/                      # Worker Node.js — dijalankan di tiap desa
│   ├── src/
│   │   ├── config/
│   │   │   └── database.js
│   │   ├── services/
│   │   │   ├── QueueService.js
│   │   │   └── WebhookService.js
│   │   ├── workers/
│   │   │   └── QueueWorker.js
│   │   └── app.js
│   ├── index.js
│   └── package.json
│
├── receiver/                    # REST API — dijalankan di server pusat
│   ├── src/
│   │   ├── config/
│   │   │   └── database.js
│   │   ├── middlewares/
│   │   │   ├── auth.js
│   │   │   └── errorHandler.js
│   │   ├── services/
│   │   │   ├── LogService.js
│   │   │   └── WarehouseService.js
│   │   ├── controllers/
│   │   │   ├── webhookController.js
│   │   │   ├── logController.js
│   │   │   └── metaController.js
│   │   ├── routes/
│   │   │   ├── webhook.js
│   │   │   ├── logs.js
│   │   │   └── meta.js
│   │   └── app.js
│   ├── index.js
│   └── package.json
│
├── monitoring_web/               # Dashboard React
│   ├── src/
│   │   ├── components/
│   │   │   ├── FilterBar.jsx
│   │   │   ├── LogTable.jsx
│   │   │   ├── PayloadDetail.jsx
│   │   │   ├── StatusBadge.jsx
│   │   │   └── Pagination.jsx
│   │   ├── pages/
│   │   │   └── MonitoringPage.jsx
│   │   ├── services/
│   │   │   ├── api.js
│   │   │   ├── logService.js
│   │   │   └── metaService.js
│   │   ├── App.jsx
│   │   └── main.jsx
│   └── package.json
└── README.md
```

---

## Prasyarat

Sebelum memulai instalasi, pastikan sudah tersedia:

- Node.js versi 18 atau lebih baru
- MySQL atau MariaDB versi 5.7+ (mendukung fungsi `JSON_OBJECT`)
- npm atau yarn
- Akses ke minimal dua server/instance database: satu untuk database desa (dapat lebih dari satu), satu untuk database induk

---

### Monitoring Web

```bash
cd monitoring_web
npm install
```

Isi `.env`:

```dotenv
VITE_API_URL=http://localhost:3000/api
VITE_POLL_INTERVAL=5000
```

Jalankan:

```bash
npm run dev
```

Dashboard dapat diakses melalui alamat yang ditampilkan Vite (umumnya `http://localhost:5173`).

---

## Alur Kerja Sistem

1. Terjadi perubahan data (`INSERT`/`UPDATE`/`DELETE`) pada tabel yang dipantau di database desa.
2. Trigger secara otomatis mencatat perubahan tersebut ke tabel `inbound_queue` dalam bentuk payload JSON.
3. Worker sender melakukan polling terhadap `inbound_queue` setiap interval tertentu, mengambil baris berstatus `PENDING`.
4. Worker mengirimkan data melalui HTTP POST ke endpoint `/api/webhook` pada receiver, disertai token autentikasi milik desa tersebut.
5. Receiver memvalidasi token, mencatat seluruh payload ke `webhook_logs`, kemudian melakukan upsert ke tabel warehouse yang sesuai.
6. Jika pengiriman gagal, worker akan menandai ulang status sebagai `PENDING` dan mencoba kembali hingga batas retry tercapai, kemudian ditandai `FAILED` jika tetap gagal.
7. Dashboard monitoring menampilkan seluruh riwayat ini secara berkala melalui endpoint `/api/logs`.

---

## Keamanan

- Setiap desa diautentikasi menggunakan token unik (`api_token`), bukan kredensial bersama, sehingga permintaan yang tidak sah dapat ditolak dan sumber data selalu dapat diidentifikasi.
- Kolom yang bersifat sensitif (kata sandi, session token) dikecualikan sejak level trigger di database desa, sehingga tidak pernah dikirim keluar sama sekali — bukan sekadar disaring di sisi penerima.
- Token disimpan sebagai variabel lingkungan (`.env`) dan tidak disertakan dalam kode sumber maupun repository.

---

## Pengujian

Pengujian alur end-to-end dapat dilakukan dengan:

1. Menjalankan `receiver` dan `sender` secara bersamaan.
2. Melakukan `INSERT`, `UPDATE`, atau `DELETE` secara manual pada tabel yang dipantau di database desa.
3. Memeriksa log pada terminal sender (`PROCESSING` → `SUCCESS`) dan receiver (`PROCESSED`/`FAILED`).
4. Memverifikasi data pada tabel warehouse di database induk.
5. Memverifikasi riwayat pada `webhook_logs`, atau melalui dashboard monitoring.

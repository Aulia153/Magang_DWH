-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Jul 2026 pada 06.55
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `desa_induk`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `desa`
--

CREATE TABLE `desa` (
  `id` int(11) NOT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `nama_desa` varchar(100) NOT NULL,
  `api_token` varchar(64) NOT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `desa`
--

INSERT INTO `desa` (`id`, `kode_desa`, `nama_desa`, `api_token`, `status`, `created_at`) VALUES
(1, 'sukamaju', 'Desa Sukamaju', '8f3a1c9e2b7d4f6a1e5c8b2d9f4a7e3c1b6d8f2a5c9e3b7d1f4a8c2e6b9d3f5a', 'ACTIVE', '2026-07-13 03:24:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dw_artikel`
--

CREATE TABLE `dw_artikel` (
  `id` bigint(20) NOT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `source_id` int(11) NOT NULL,
  `gambar` varchar(200) DEFAULT NULL,
  `isi` longtext DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  `tgl_upload` timestamp NULL DEFAULT NULL,
  `id_kategori` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `judul` varchar(200) DEFAULT NULL,
  `gambar1` varchar(200) DEFAULT NULL,
  `gambar2` varchar(200) DEFAULT NULL,
  `gambar3` varchar(200) DEFAULT NULL,
  `dokumen` varchar(400) DEFAULT NULL,
  `link_dokumen` varchar(200) DEFAULT NULL,
  `boleh_komentar` tinyint(4) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `hit` int(11) DEFAULT NULL,
  `slider` tinyint(4) DEFAULT NULL,
  `synced_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dw_artikel`
--

INSERT INTO `dw_artikel` (`id`, `kode_desa`, `source_id`, `gambar`, `isi`, `enabled`, `tgl_upload`, `id_kategori`, `id_user`, `judul`, `gambar1`, `gambar2`, `gambar3`, `dokumen`, `link_dokumen`, `boleh_komentar`, `slug`, `hit`, `slider`, `synced_at`) VALUES
(2, 'sukamaju', 2, 'berita-1.jpg', '<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>', 1, '2026-07-13 04:39:52', 1, 3, 'Website Resmi Desa Sukamaju Telah Diluncurkan', NULL, NULL, NULL, NULL, NULL, 1, 'website-resmi-desa-sukamaju-telah-diluncurkan', 0, 1, '2026-07-13 04:40:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dw_config`
--

CREATE TABLE `dw_config` (
  `id` bigint(20) NOT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `source_id` int(11) NOT NULL,
  `app_key` varchar(100) DEFAULT NULL,
  `nama_desa` varchar(100) DEFAULT NULL,
  `kode_desa_bps` varchar(10) DEFAULT NULL,
  `kode_pos` int(11) DEFAULT NULL,
  `nama_kecamatan` varchar(100) DEFAULT NULL,
  `kode_kecamatan` varchar(6) DEFAULT NULL,
  `nama_kepala_camat` varchar(100) DEFAULT NULL,
  `nip_kepala_camat` varchar(100) DEFAULT NULL,
  `nama_kabupaten` varchar(100) DEFAULT NULL,
  `kode_kabupaten` varchar(4) DEFAULT NULL,
  `nama_propinsi` varchar(100) DEFAULT NULL,
  `kode_propinsi` varchar(2) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `lat` varchar(20) DEFAULT NULL,
  `lng` varchar(20) DEFAULT NULL,
  `alamat_kantor` varchar(200) DEFAULT NULL,
  `telepon` varchar(50) DEFAULT NULL,
  `kantor_desa` varchar(100) DEFAULT NULL,
  `synced_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dw_config`
--

INSERT INTO `dw_config` (`id`, `kode_desa`, `source_id`, `app_key`, `nama_desa`, `kode_desa_bps`, `kode_pos`, `nama_kecamatan`, `kode_kecamatan`, `nama_kepala_camat`, `nip_kepala_camat`, `nama_kabupaten`, `kode_kabupaten`, `nama_propinsi`, `kode_propinsi`, `logo`, `lat`, `lng`, `alamat_kantor`, `telepon`, `kantor_desa`, `synced_at`) VALUES
(1, 'sukamaju', 2, 'APPKEY-SUKAMAJU-001', 'Desa Sukamaju', '3501012001', 61234, 'Kecamatan Sukamaju', '350101', 'Budi Santoso', '197001011990011001', 'Kabupaten Sejahtera', '3501', 'Jawa Timur', '35', 'logo.png', '-7.257472', '112.752090', 'Jl. Raya Sukamaju No. 1', '0311234567', 'Kantor Desa Sukamaju', '2026-07-13 04:32:17');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dw_kategori`
--

CREATE TABLE `dw_kategori` (
  `id` bigint(20) NOT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `source_id` int(11) NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `tipe` int(11) DEFAULT NULL,
  `urut` tinyint(4) DEFAULT NULL,
  `enabled` tinyint(4) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `synced_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dw_kategori`
--

INSERT INTO `dw_kategori` (`id`, `kode_desa`, `source_id`, `kategori`, `tipe`, `urut`, `enabled`, `parent`, `slug`, `synced_at`) VALUES
(1, 'sukamaju', 1, 'Berita', 1, 1, 1, 0, 'berita', '2026-07-13 04:37:21'),
(2, 'sukamaju', 2, 'Pengumuman', 1, 2, 1, 0, 'pengumuman', '2026-07-13 04:37:21'),
(3, 'sukamaju', 3, 'Kegiatan', 1, 3, 1, 0, 'kegiatan', '2026-07-13 04:37:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dw_komentar`
--

CREATE TABLE `dw_komentar` (
  `id` bigint(20) NOT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `source_id` int(11) NOT NULL,
  `id_artikel` int(11) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `subjek` tinytext DEFAULT NULL,
  `komentar` text DEFAULT NULL,
  `tgl_upload` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `tipe` tinyint(4) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `is_archived` tinyint(4) DEFAULT NULL,
  `synced_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dw_komentar`
--

INSERT INTO `dw_komentar` (`id`, `kode_desa`, `source_id`, `id_artikel`, `owner`, `email`, `subjek`, `komentar`, `tgl_upload`, `status`, `tipe`, `no_hp`, `is_archived`, `synced_at`) VALUES
(1, 'sukamaju', 1, 2, 'Andi', 'andi@example.com', 'Komentar', 'Semoga website desa ini bermanfaat bagi seluruh warga.', '2026-07-13 04:41:07', 1, 1, '081234567890', 0, '2026-07-13 04:41:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dw_user`
--

CREATE TABLE `dw_user` (
  `id` bigint(20) NOT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `source_id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `id_grup` int(11) DEFAULT NULL,
  `pamong_id` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `synced_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dw_user`
--

INSERT INTO `dw_user` (`id`, `kode_desa`, `source_id`, `username`, `id_grup`, `pamong_id`, `email`, `last_login`, `active`, `nama`, `phone`, `foto`, `synced_at`) VALUES
(4, 'sukamaju', 3, 'admin', 1, NULL, 'admin@sukamaju.id', '2026-07-13 11:36:35', 1, 'Administrator', '081234567890', 'admin.jpg', '2026-07-13 04:36:36');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dw_user_login_history`
--

CREATE TABLE `dw_user_login_history` (
  `id` bigint(20) NOT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `source_id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `login_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `synced_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `webhook_logs`
--

CREATE TABLE `webhook_logs` (
  `id` bigint(20) NOT NULL,
  `event_id` varchar(40) DEFAULT NULL,
  `kode_desa` varchar(10) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `action` varchar(20) NOT NULL,
  `record_id` int(11) DEFAULT NULL,
  `payload` longtext DEFAULT NULL,
  `status` enum('RECEIVED','PROCESSED','FAILED') NOT NULL DEFAULT 'RECEIVED',
  `error_message` text DEFAULT NULL,
  `received_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `processed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `webhook_logs`
--

INSERT INTO `webhook_logs` (`id`, `event_id`, `kode_desa`, `table_name`, `action`, `record_id`, `payload`, `status`, `error_message`, `received_at`, `processed_at`) VALUES
(10, 'd4730c65-7e73-11f1-9e37-c3c48c71938c', 'sukamaju', 'config', 'INSERT', 2, '{\"app_key\":\"APPKEY-SUKAMAJU-001\",\"nama_desa\":\"Desa Sukamaju\",\"kode_desa\":\"sukamaju\",\"kode_desa_bps\":\"3501012001\",\"kode_pos\":61234,\"nama_kecamatan\":\"Kecamatan Sukamaju\",\"kode_kecamatan\":\"350101\",\"nama_kepala_camat\":\"Budi Santoso\",\"nip_kepala_camat\":\"197001011990011001\",\"nama_kabupaten\":\"Kabupaten Sejahtera\",\"kode_kabupaten\":\"3501\",\"nama_propinsi\":\"Jawa Timur\",\"kode_propinsi\":\"35\",\"logo\":\"logo.png\",\"lat\":\"-7.257472\",\"lng\":\"112.752090\",\"alamat_kantor\":\"Jl. Raya Sukamaju No. 1\",\"telepon\":\"0311234567\",\"kantor_desa\":\"Kantor Desa Sukamaju\"}', 'PROCESSED', NULL, '2026-07-13 04:32:17', '2026-07-13 04:32:17'),
(11, '6e23201b-7e74-11f1-9e37-c3c48c71938c', 'sukamaju', 'user', 'INSERT', 3, '{\"username\":\"admin\",\"id_grup\":1,\"pamong_id\":null,\"email\":\"admin@sukamaju.id\",\"last_login\":\"2026-07-13 11:36:35\",\"active\":1,\"nama\":\"Administrator\",\"phone\":\"081234567890\",\"foto\":\"admin.jpg\"}', 'PROCESSED', NULL, '2026-07-13 04:36:36', '2026-07-13 04:36:36'),
(12, '8934c200-7e74-11f1-9e37-c3c48c71938c', 'sukamaju', 'kategori', 'INSERT', 1, '{\"kategori\":\"Berita\",\"tipe\":1,\"urut\":1,\"enabled\":1,\"parent\":0,\"slug\":\"berita\"}', 'PROCESSED', NULL, '2026-07-13 04:37:21', '2026-07-13 04:37:21'),
(13, '8934c685-7e74-11f1-9e37-c3c48c71938c', 'sukamaju', 'kategori', 'INSERT', 2, '{\"kategori\":\"Pengumuman\",\"tipe\":1,\"urut\":2,\"enabled\":1,\"parent\":0,\"slug\":\"pengumuman\"}', 'PROCESSED', NULL, '2026-07-13 04:37:21', '2026-07-13 04:37:21'),
(14, '8934c747-7e74-11f1-9e37-c3c48c71938c', 'sukamaju', 'kategori', 'INSERT', 3, '{\"kategori\":\"Kegiatan\",\"tipe\":1,\"urut\":3,\"enabled\":1,\"parent\":0,\"slug\":\"kegiatan\"}', 'PROCESSED', NULL, '2026-07-13 04:37:21', '2026-07-13 04:37:21'),
(15, 'c49aa47e-7e74-11f1-9e37-c3c48c71938c', 'sukamaju', 'user', 'UPDATE', 3, '{\"old\":{\"username\":\"admin\",\"id_grup\":1,\"pamong_id\":null,\"email\":\"admin@sukamaju.id\",\"last_login\":\"2026-07-13 11:36:35\",\"active\":1,\"nama\":\"Administrator\",\"phone\":\"081234567890\",\"foto\":\"admin.jpg\"},\"new\":{\"username\":\"admin\",\"id_grup\":1,\"pamong_id\":null,\"email\":\"admin@sukamaju.id\",\"last_login\":\"2026-07-13 11:36:35\",\"active\":1,\"nama\":\"Administrator\",\"phone\":\"081234567890\",\"foto\":\"admin.jpg\"}}', 'PROCESSED', NULL, '2026-07-13 04:39:01', '2026-07-13 04:39:01'),
(16, 'e362ecdf-7e74-11f1-9e37-c3c48c71938c', 'sukamaju', 'artikel', 'INSERT', 2, '{\"gambar\":\"berita-1.jpg\",\"isi\":\"<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>\",\"enabled\":1,\"tgl_upload\":\"2026-07-13 11:39:52\",\"id_kategori\":1,\"id_user\":1,\"judul\":\"Website Resmi Desa Sukamaju Telah Diluncurkan\",\"gambar1\":null,\"gambar2\":null,\"gambar3\":null,\"dokumen\":null,\"link_dokumen\":null,\"boleh_komentar\":1,\"slug\":\"website-resmi-desa-sukamaju-telah-diluncurkan\",\"hit\":0,\"slider\":1}', 'PROCESSED', NULL, '2026-07-13 04:39:52', '2026-07-13 04:39:52'),
(17, 'f347f0cc-7e74-11f1-9e37-c3c48c71938c', 'sukamaju', 'artikel', 'UPDATE', 2, '{\"old\":{\"gambar\":\"berita-1.jpg\",\"isi\":\"<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>\",\"enabled\":1,\"tgl_upload\":\"2026-07-13 11:39:52\",\"id_kategori\":1,\"id_user\":1,\"judul\":\"Website Resmi Desa Sukamaju Telah Diluncurkan\",\"gambar1\":null,\"gambar2\":null,\"gambar3\":null,\"dokumen\":null,\"link_dokumen\":null,\"boleh_komentar\":1,\"slug\":\"website-resmi-desa-sukamaju-telah-diluncurkan\",\"hit\":0,\"slider\":1},\"new\":{\"gambar\":\"berita-1.jpg\",\"isi\":\"<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>\",\"enabled\":1,\"tgl_upload\":\"2026-07-13 11:39:52\",\"id_kategori\":1,\"id_user\":3,\"judul\":\"Website Resmi Desa Sukamaju Telah Diluncurkan\",\"gambar1\":null,\"gambar2\":null,\"gambar3\":null,\"dokumen\":null,\"link_dokumen\":null,\"boleh_komentar\":1,\"slug\":\"website-resmi-desa-sukamaju-telah-diluncurkan\",\"hit\":0,\"slider\":1}}', 'PROCESSED', NULL, '2026-07-13 04:40:19', '2026-07-13 04:40:19'),
(18, '106bae0e-7e75-11f1-9e37-c3c48c71938c', 'sukamaju', 'komentar', 'INSERT', 1, '{\"id_artikel\":1,\"owner\":\"Andi\",\"email\":\"andi@example.com\",\"subjek\":\"Komentar\",\"komentar\":\"Semoga website desa ini bermanfaat bagi seluruh warga.\",\"tgl_upload\":\"2026-07-13 11:41:07\",\"status\":1,\"tipe\":1,\"no_hp\":\"081234567890\",\"is_archived\":0}', 'PROCESSED', NULL, '2026-07-13 04:41:07', '2026-07-13 04:41:07'),
(19, '271710ed-7e75-11f1-9e37-c3c48c71938c', 'sukamaju', 'komentar', 'UPDATE', 1, '{\"old\":{\"id_artikel\":1,\"owner\":\"Andi\",\"email\":\"andi@example.com\",\"subjek\":\"Komentar\",\"komentar\":\"Semoga website desa ini bermanfaat bagi seluruh warga.\",\"tgl_upload\":\"2026-07-13 11:41:07\",\"status\":1,\"tipe\":1,\"no_hp\":\"081234567890\",\"is_archived\":0},\"new\":{\"id_artikel\":2,\"owner\":\"Andi\",\"email\":\"andi@example.com\",\"subjek\":\"Komentar\",\"komentar\":\"Semoga website desa ini bermanfaat bagi seluruh warga.\",\"tgl_upload\":\"2026-07-13 11:41:07\",\"status\":1,\"tipe\":1,\"no_hp\":\"081234567890\",\"is_archived\":0}}', 'PROCESSED', NULL, '2026-07-13 04:41:46', '2026-07-13 04:41:46');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `desa`
--
ALTER TABLE `desa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_desa` (`kode_desa`),
  ADD UNIQUE KEY `api_token` (`api_token`);

--
-- Indeks untuk tabel `dw_artikel`
--
ALTER TABLE `dw_artikel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_source` (`kode_desa`,`source_id`);

--
-- Indeks untuk tabel `dw_config`
--
ALTER TABLE `dw_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_source` (`kode_desa`,`source_id`);

--
-- Indeks untuk tabel `dw_kategori`
--
ALTER TABLE `dw_kategori`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_source` (`kode_desa`,`source_id`);

--
-- Indeks untuk tabel `dw_komentar`
--
ALTER TABLE `dw_komentar`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_source` (`kode_desa`,`source_id`);

--
-- Indeks untuk tabel `dw_user`
--
ALTER TABLE `dw_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_source` (`kode_desa`,`source_id`);

--
-- Indeks untuk tabel `dw_user_login_history`
--
ALTER TABLE `dw_user_login_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_source` (`kode_desa`,`source_id`);

--
-- Indeks untuk tabel `webhook_logs`
--
ALTER TABLE `webhook_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_desa_table` (`kode_desa`,`table_name`),
  ADD KEY `idx_event` (`event_id`),
  ADD KEY `idx_status` (`status`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `desa`
--
ALTER TABLE `desa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `dw_artikel`
--
ALTER TABLE `dw_artikel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `dw_config`
--
ALTER TABLE `dw_config`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `dw_kategori`
--
ALTER TABLE `dw_kategori`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `dw_komentar`
--
ALTER TABLE `dw_komentar`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `dw_user`
--
ALTER TABLE `dw_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `dw_user_login_history`
--
ALTER TABLE `dw_user_login_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `webhook_logs`
--
ALTER TABLE `webhook_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

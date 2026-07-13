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
-- Database: `desa`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `artikel`
--

CREATE TABLE `artikel` (
  `id` int(11) NOT NULL,
  `config_id` int(11) DEFAULT NULL,
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
  `slider` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `artikel`
--

INSERT INTO `artikel` (`id`, `config_id`, `gambar`, `isi`, `enabled`, `tgl_upload`, `id_kategori`, `id_user`, `judul`, `gambar1`, `gambar2`, `gambar3`, `dokumen`, `link_dokumen`, `boleh_komentar`, `slug`, `hit`, `slider`) VALUES
(2, 2, 'berita-1.jpg', '<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>', 1, '2026-07-13 04:39:52', 1, 3, 'Website Resmi Desa Sukamaju Telah Diluncurkan', NULL, NULL, NULL, NULL, NULL, 1, 'website-resmi-desa-sukamaju-telah-diluncurkan', 0, 1);

--
-- Trigger `artikel`
--
DELIMITER $$
CREATE TRIGGER `trg_artikel_delete` AFTER DELETE ON `artikel` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (UUID(), OLD.config_id, 'DELETE', 'artikel', OLD.id, JSON_OBJECT('id', OLD.id), 'pending', 0, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_artikel_insert` AFTER INSERT ON `artikel` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'INSERT', 'artikel', NEW.id,
    JSON_OBJECT(
      'gambar', NEW.gambar, 'isi', NEW.isi, 'enabled', NEW.enabled, 'tgl_upload', NEW.tgl_upload,
      'id_kategori', NEW.id_kategori, 'id_user', NEW.id_user, 'judul', NEW.judul,
      'gambar1', NEW.gambar1, 'gambar2', NEW.gambar2, 'gambar3', NEW.gambar3,
      'dokumen', NEW.dokumen, 'link_dokumen', NEW.link_dokumen, 'boleh_komentar', NEW.boleh_komentar,
      'slug', NEW.slug, 'hit', NEW.hit, 'slider', NEW.slider
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_artikel_update` AFTER UPDATE ON `artikel` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'UPDATE', 'artikel', NEW.id,
    JSON_OBJECT(
      'old', JSON_OBJECT(
        'gambar', OLD.gambar, 'isi', OLD.isi, 'enabled', OLD.enabled, 'tgl_upload', OLD.tgl_upload,
        'id_kategori', OLD.id_kategori, 'id_user', OLD.id_user, 'judul', OLD.judul,
        'gambar1', OLD.gambar1, 'gambar2', OLD.gambar2, 'gambar3', OLD.gambar3,
        'dokumen', OLD.dokumen, 'link_dokumen', OLD.link_dokumen, 'boleh_komentar', OLD.boleh_komentar,
        'slug', OLD.slug, 'hit', OLD.hit, 'slider', OLD.slider
      ),
      'new', JSON_OBJECT(
        'gambar', NEW.gambar, 'isi', NEW.isi, 'enabled', NEW.enabled, 'tgl_upload', NEW.tgl_upload,
        'id_kategori', NEW.id_kategori, 'id_user', NEW.id_user, 'judul', NEW.judul,
        'gambar1', NEW.gambar1, 'gambar2', NEW.gambar2, 'gambar3', NEW.gambar3,
        'dokumen', NEW.dokumen, 'link_dokumen', NEW.link_dokumen, 'boleh_komentar', NEW.boleh_komentar,
        'slug', NEW.slug, 'hit', NEW.hit, 'slider', NEW.slider
      )
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `config`
--

CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `app_key` varchar(100) DEFAULT NULL,
  `nama_desa` varchar(100) DEFAULT NULL,
  `kode_desa` varchar(10) DEFAULT NULL,
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
  `path` text DEFAULT NULL,
  `alamat_kantor` varchar(200) DEFAULT NULL,
  `telepon` varchar(50) DEFAULT NULL,
  `kantor_desa` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `config`
--

INSERT INTO `config` (`id`, `app_key`, `nama_desa`, `kode_desa`, `kode_desa_bps`, `kode_pos`, `nama_kecamatan`, `kode_kecamatan`, `nama_kepala_camat`, `nip_kepala_camat`, `nama_kabupaten`, `kode_kabupaten`, `nama_propinsi`, `kode_propinsi`, `logo`, `lat`, `lng`, `path`, `alamat_kantor`, `telepon`, `kantor_desa`, `created_at`, `updated_at`) VALUES
(2, 'APPKEY-SUKAMAJU-001', 'Desa Sukamaju', 'sukamaju', '3501012001', 61234, 'Kecamatan Sukamaju', '350101', 'Budi Santoso', '197001011990011001', 'Kabupaten Sejahtera', '3501', 'Jawa Timur', '35', 'logo.png', '-7.257472', '112.752090', '/var/www/html/desa', 'Jl. Raya Sukamaju No. 1', '0311234567', 'Kantor Desa Sukamaju', '2026-07-13 04:32:17', '2026-07-13 04:32:17');

--
-- Trigger `config`
--
DELIMITER $$
CREATE TRIGGER `trg_config_delete` AFTER DELETE ON `config` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (UUID(), OLD.id, 'DELETE', 'config', OLD.id, JSON_OBJECT('id', OLD.id), 'pending', 0, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_config_insert` AFTER INSERT ON `config` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.id, 'INSERT', 'config', NEW.id,
    JSON_OBJECT(
      'app_key', NEW.app_key, 'nama_desa', NEW.nama_desa, 'kode_desa', NEW.kode_desa,
      'kode_desa_bps', NEW.kode_desa_bps, 'kode_pos', NEW.kode_pos,
      'nama_kecamatan', NEW.nama_kecamatan, 'kode_kecamatan', NEW.kode_kecamatan,
      'nama_kepala_camat', NEW.nama_kepala_camat, 'nip_kepala_camat', NEW.nip_kepala_camat,
      'nama_kabupaten', NEW.nama_kabupaten, 'kode_kabupaten', NEW.kode_kabupaten,
      'nama_propinsi', NEW.nama_propinsi, 'kode_propinsi', NEW.kode_propinsi,
      'logo', NEW.logo, 'lat', NEW.lat, 'lng', NEW.lng,
      'alamat_kantor', NEW.alamat_kantor, 'telepon', NEW.telepon, 'kantor_desa', NEW.kantor_desa
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_config_update` AFTER UPDATE ON `config` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.id, 'UPDATE', 'config', NEW.id,
    JSON_OBJECT(
      'old', JSON_OBJECT(
        'app_key', OLD.app_key, 'nama_desa', OLD.nama_desa, 'kode_desa', OLD.kode_desa,
        'kode_desa_bps', OLD.kode_desa_bps, 'kode_pos', OLD.kode_pos,
        'nama_kecamatan', OLD.nama_kecamatan, 'kode_kecamatan', OLD.kode_kecamatan,
        'nama_kepala_camat', OLD.nama_kepala_camat, 'nip_kepala_camat', OLD.nip_kepala_camat,
        'nama_kabupaten', OLD.nama_kabupaten, 'kode_kabupaten', OLD.kode_kabupaten,
        'nama_propinsi', OLD.nama_propinsi, 'kode_propinsi', OLD.kode_propinsi,
        'logo', OLD.logo, 'lat', OLD.lat, 'lng', OLD.lng,
        'alamat_kantor', OLD.alamat_kantor, 'telepon', OLD.telepon, 'kantor_desa', OLD.kantor_desa
      ),
      'new', JSON_OBJECT(
        'app_key', NEW.app_key, 'nama_desa', NEW.nama_desa, 'kode_desa', NEW.kode_desa,
        'kode_desa_bps', NEW.kode_desa_bps, 'kode_pos', NEW.kode_pos,
        'nama_kecamatan', NEW.nama_kecamatan, 'kode_kecamatan', NEW.kode_kecamatan,
        'nama_kepala_camat', NEW.nama_kepala_camat, 'nip_kepala_camat', NEW.nip_kepala_camat,
        'nama_kabupaten', NEW.nama_kabupaten, 'kode_kabupaten', NEW.kode_kabupaten,
        'nama_propinsi', NEW.nama_propinsi, 'kode_propinsi', NEW.kode_propinsi,
        'logo', NEW.logo, 'lat', NEW.lat, 'lng', NEW.lng,
        'alamat_kantor', NEW.alamat_kantor, 'telepon', NEW.telepon, 'kantor_desa', NEW.kantor_desa
      )
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inbound_queue`
--

CREATE TABLE `inbound_queue` (
  `id` int(11) NOT NULL,
  `event_id` varchar(100) DEFAULT NULL,
  `config_id` int(11) DEFAULT NULL,
  `event_type` varchar(20) DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `status` enum('pending','success','failed','retry') DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `received_at` timestamp NULL DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `inbound_queue`
--

INSERT INTO `inbound_queue` (`id`, `event_id`, `config_id`, `event_type`, `table_name`, `record_id`, `payload`, `status`, `retry_count`, `error_message`, `received_at`, `processed_at`) VALUES
(10, 'd4730c65-7e73-11f1-9e37-c3c48c71938c', 2, 'INSERT', 'config', 2, '{\"app_key\": \"APPKEY-SUKAMAJU-001\", \"nama_desa\": \"Desa Sukamaju\", \"kode_desa\": \"sukamaju\", \"kode_desa_bps\": \"3501012001\", \"kode_pos\": 61234, \"nama_kecamatan\": \"Kecamatan Sukamaju\", \"kode_kecamatan\": \"350101\", \"nama_kepala_camat\": \"Budi Santoso\", \"nip_kepala_camat\": \"197001011990011001\", \"nama_kabupaten\": \"Kabupaten Sejahtera\", \"kode_kabupaten\": \"3501\", \"nama_propinsi\": \"Jawa Timur\", \"kode_propinsi\": \"35\", \"logo\": \"logo.png\", \"lat\": \"-7.257472\", \"lng\": \"112.752090\", \"alamat_kantor\": \"Jl. Raya Sukamaju No. 1\", \"telepon\": \"0311234567\", \"kantor_desa\": \"Kantor Desa Sukamaju\"}', 'success', 0, NULL, '2026-07-13 04:32:17', '2026-07-13 04:32:17'),
(11, '6e23201b-7e74-11f1-9e37-c3c48c71938c', 1, 'INSERT', 'user', 3, '{\"username\": \"admin\", \"id_grup\": 1, \"pamong_id\": null, \"email\": \"admin@sukamaju.id\", \"last_login\": \"2026-07-13 11:36:35\", \"active\": 1, \"nama\": \"Administrator\", \"phone\": \"081234567890\", \"foto\": \"admin.jpg\"}', 'success', 0, NULL, '2026-07-13 04:36:35', '2026-07-13 04:36:36'),
(12, '8934c200-7e74-11f1-9e37-c3c48c71938c', 1, 'INSERT', 'kategori', 1, '{\"kategori\": \"Berita\", \"tipe\": 1, \"urut\": 1, \"enabled\": 1, \"parent\": 0, \"slug\": \"berita\"}', 'success', 0, NULL, '2026-07-13 04:37:20', '2026-07-13 04:37:21'),
(13, '8934c685-7e74-11f1-9e37-c3c48c71938c', 1, 'INSERT', 'kategori', 2, '{\"kategori\": \"Pengumuman\", \"tipe\": 1, \"urut\": 2, \"enabled\": 1, \"parent\": 0, \"slug\": \"pengumuman\"}', 'success', 0, NULL, '2026-07-13 04:37:20', '2026-07-13 04:37:21'),
(14, '8934c747-7e74-11f1-9e37-c3c48c71938c', 1, 'INSERT', 'kategori', 3, '{\"kategori\": \"Kegiatan\", \"tipe\": 1, \"urut\": 3, \"enabled\": 1, \"parent\": 0, \"slug\": \"kegiatan\"}', 'success', 0, NULL, '2026-07-13 04:37:20', '2026-07-13 04:37:21'),
(15, 'c49aa47e-7e74-11f1-9e37-c3c48c71938c', 2, 'UPDATE', 'user', 3, '{\"old\": {\"username\": \"admin\", \"id_grup\": 1, \"pamong_id\": null, \"email\": \"admin@sukamaju.id\", \"last_login\": \"2026-07-13 11:36:35\", \"active\": 1, \"nama\": \"Administrator\", \"phone\": \"081234567890\", \"foto\": \"admin.jpg\"}, \"new\": {\"username\": \"admin\", \"id_grup\": 1, \"pamong_id\": null, \"email\": \"admin@sukamaju.id\", \"last_login\": \"2026-07-13 11:36:35\", \"active\": 1, \"nama\": \"Administrator\", \"phone\": \"081234567890\", \"foto\": \"admin.jpg\"}}', 'success', 0, NULL, '2026-07-13 04:39:00', '2026-07-13 04:39:01'),
(16, 'e362ecdf-7e74-11f1-9e37-c3c48c71938c', 2, 'INSERT', 'artikel', 2, '{\"gambar\": \"berita-1.jpg\", \"isi\": \"<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>\", \"enabled\": 1, \"tgl_upload\": \"2026-07-13 11:39:52\", \"id_kategori\": 1, \"id_user\": 1, \"judul\": \"Website Resmi Desa Sukamaju Telah Diluncurkan\", \"gambar1\": null, \"gambar2\": null, \"gambar3\": null, \"dokumen\": null, \"link_dokumen\": null, \"boleh_komentar\": 1, \"slug\": \"website-resmi-desa-sukamaju-telah-diluncurkan\", \"hit\": 0, \"slider\": 1}', 'success', 0, NULL, '2026-07-13 04:39:52', '2026-07-13 04:39:52'),
(17, 'f347f0cc-7e74-11f1-9e37-c3c48c71938c', 2, 'UPDATE', 'artikel', 2, '{\"old\": {\"gambar\": \"berita-1.jpg\", \"isi\": \"<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>\", \"enabled\": 1, \"tgl_upload\": \"2026-07-13 11:39:52\", \"id_kategori\": 1, \"id_user\": 1, \"judul\": \"Website Resmi Desa Sukamaju Telah Diluncurkan\", \"gambar1\": null, \"gambar2\": null, \"gambar3\": null, \"dokumen\": null, \"link_dokumen\": null, \"boleh_komentar\": 1, \"slug\": \"website-resmi-desa-sukamaju-telah-diluncurkan\", \"hit\": 0, \"slider\": 1}, \"new\": {\"gambar\": \"berita-1.jpg\", \"isi\": \"<p>Pemerintah Desa Sukamaju mengucapkan selamat datang di website resmi desa. Website ini digunakan untuk memberikan informasi, pengumuman, dan kegiatan desa kepada masyarakat.</p>\", \"enabled\": 1, \"tgl_upload\": \"2026-07-13 11:39:52\", \"id_kategori\": 1, \"id_user\": 3, \"judul\": \"Website Resmi Desa Sukamaju Telah Diluncurkan\", \"gambar1\": null, \"gambar2\": null, \"gambar3\": null, \"dokumen\": null, \"link_dokumen\": null, \"boleh_komentar\": 1, \"slug\": \"website-resmi-desa-sukamaju-telah-diluncurkan\", \"hit\": 0, \"slider\": 1}}', 'success', 0, NULL, '2026-07-13 04:40:18', '2026-07-13 04:40:19'),
(18, '106bae0e-7e75-11f1-9e37-c3c48c71938c', 2, 'INSERT', 'komentar', 1, '{\"id_artikel\": 1, \"owner\": \"Andi\", \"email\": \"andi@example.com\", \"subjek\": \"Komentar\", \"komentar\": \"Semoga website desa ini bermanfaat bagi seluruh warga.\", \"tgl_upload\": \"2026-07-13 11:41:07\", \"status\": 1, \"tipe\": 1, \"no_hp\": \"081234567890\", \"is_archived\": 0}', 'success', 0, NULL, '2026-07-13 04:41:07', '2026-07-13 04:41:07'),
(19, '271710ed-7e75-11f1-9e37-c3c48c71938c', 2, 'UPDATE', 'komentar', 1, '{\"old\": {\"id_artikel\": 1, \"owner\": \"Andi\", \"email\": \"andi@example.com\", \"subjek\": \"Komentar\", \"komentar\": \"Semoga website desa ini bermanfaat bagi seluruh warga.\", \"tgl_upload\": \"2026-07-13 11:41:07\", \"status\": 1, \"tipe\": 1, \"no_hp\": \"081234567890\", \"is_archived\": 0}, \"new\": {\"id_artikel\": 2, \"owner\": \"Andi\", \"email\": \"andi@example.com\", \"subjek\": \"Komentar\", \"komentar\": \"Semoga website desa ini bermanfaat bagi seluruh warga.\", \"tgl_upload\": \"2026-07-13 11:41:07\", \"status\": 1, \"tipe\": 1, \"no_hp\": \"081234567890\", \"is_archived\": 0}}', 'success', 0, NULL, '2026-07-13 04:41:45', '2026-07-13 04:41:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `config_id` int(11) DEFAULT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `tipe` int(11) DEFAULT NULL,
  `urut` tinyint(4) DEFAULT NULL,
  `enabled` tinyint(4) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `config_id`, `kategori`, `tipe`, `urut`, `enabled`, `parent`, `slug`) VALUES
(1, 1, 'Berita', 1, 1, 1, 0, 'berita'),
(2, 1, 'Pengumuman', 1, 2, 1, 0, 'pengumuman'),
(3, 1, 'Kegiatan', 1, 3, 1, 0, 'kegiatan');

--
-- Trigger `kategori`
--
DELIMITER $$
CREATE TRIGGER `trg_kategori_delete` AFTER DELETE ON `kategori` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (UUID(), OLD.config_id, 'DELETE', 'kategori', OLD.id, JSON_OBJECT('id', OLD.id), 'pending', 0, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_kategori_insert` AFTER INSERT ON `kategori` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'INSERT', 'kategori', NEW.id,
    JSON_OBJECT('kategori', NEW.kategori, 'tipe', NEW.tipe, 'urut', NEW.urut, 'enabled', NEW.enabled, 'parent', NEW.parent, 'slug', NEW.slug),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_kategori_update` AFTER UPDATE ON `kategori` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'UPDATE', 'kategori', NEW.id,
    JSON_OBJECT(
      'old', JSON_OBJECT('kategori', OLD.kategori, 'tipe', OLD.tipe, 'urut', OLD.urut, 'enabled', OLD.enabled, 'parent', OLD.parent, 'slug', OLD.slug),
      'new', JSON_OBJECT('kategori', NEW.kategori, 'tipe', NEW.tipe, 'urut', NEW.urut, 'enabled', NEW.enabled, 'parent', NEW.parent, 'slug', NEW.slug)
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `komentar`
--

CREATE TABLE `komentar` (
  `id` int(11) NOT NULL,
  `config_id` int(11) DEFAULT NULL,
  `id_artikel` int(11) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `subjek` tinytext DEFAULT NULL,
  `komentar` text DEFAULT NULL,
  `tgl_upload` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `tipe` tinyint(4) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_archived` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `komentar`
--

INSERT INTO `komentar` (`id`, `config_id`, `id_artikel`, `owner`, `email`, `subjek`, `komentar`, `tgl_upload`, `status`, `tipe`, `no_hp`, `updated_at`, `is_archived`) VALUES
(1, 2, 2, 'Andi', 'andi@example.com', 'Komentar', 'Semoga website desa ini bermanfaat bagi seluruh warga.', '2026-07-13 04:41:07', 1, 1, '081234567890', '2026-07-13 04:41:07', 0);

--
-- Trigger `komentar`
--
DELIMITER $$
CREATE TRIGGER `trg_komentar_delete` AFTER DELETE ON `komentar` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (UUID(), OLD.config_id, 'DELETE', 'komentar', OLD.id, JSON_OBJECT('id', OLD.id), 'pending', 0, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_komentar_insert` AFTER INSERT ON `komentar` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'INSERT', 'komentar', NEW.id,
    JSON_OBJECT(
      'id_artikel', NEW.id_artikel, 'owner', NEW.owner, 'email', NEW.email, 'subjek', NEW.subjek,
      'komentar', NEW.komentar, 'tgl_upload', NEW.tgl_upload, 'status', NEW.status,
      'tipe', NEW.tipe, 'no_hp', NEW.no_hp, 'is_archived', NEW.is_archived
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_komentar_update` AFTER UPDATE ON `komentar` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'UPDATE', 'komentar', NEW.id,
    JSON_OBJECT(
      'old', JSON_OBJECT(
        'id_artikel', OLD.id_artikel, 'owner', OLD.owner, 'email', OLD.email, 'subjek', OLD.subjek,
        'komentar', OLD.komentar, 'tgl_upload', OLD.tgl_upload, 'status', OLD.status,
        'tipe', OLD.tipe, 'no_hp', OLD.no_hp, 'is_archived', OLD.is_archived
      ),
      'new', JSON_OBJECT(
        'id_artikel', NEW.id_artikel, 'owner', NEW.owner, 'email', NEW.email, 'subjek', NEW.subjek,
        'komentar', NEW.komentar, 'tgl_upload', NEW.tgl_upload, 'status', NEW.status,
        'tipe', NEW.tipe, 'no_hp', NEW.no_hp, 'is_archived', NEW.is_archived
      )
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `config_id` int(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `id_grup` int(11) DEFAULT NULL,
  `pamong_id` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `session` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `config_id`, `username`, `password`, `id_grup`, `pamong_id`, `email`, `last_login`, `active`, `nama`, `phone`, `foto`, `session`) VALUES
(3, 2, 'admin', 'admin123', 1, NULL, 'admin@sukamaju.id', '2026-07-13 11:36:35', 1, 'Administrator', '081234567890', 'admin.jpg', NULL);

--
-- Trigger `user`
--
DELIMITER $$
CREATE TRIGGER `trg_user_delete` AFTER DELETE ON `user` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (UUID(), OLD.config_id, 'DELETE', 'user', OLD.id, JSON_OBJECT('id', OLD.id), 'pending', 0, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_user_insert` AFTER INSERT ON `user` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'INSERT', 'user', NEW.id,
    JSON_OBJECT(
      'username', NEW.username, 'id_grup', NEW.id_grup, 'pamong_id', NEW.pamong_id,
      'email', NEW.email, 'last_login', NEW.last_login, 'active', NEW.active,
      'nama', NEW.nama, 'phone', NEW.phone, 'foto', NEW.foto
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_user_update` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'UPDATE', 'user', NEW.id,
    JSON_OBJECT(
      'old', JSON_OBJECT(
        'username', OLD.username, 'id_grup', OLD.id_grup, 'pamong_id', OLD.pamong_id,
        'email', OLD.email, 'last_login', OLD.last_login, 'active', OLD.active,
        'nama', OLD.nama, 'phone', OLD.phone, 'foto', OLD.foto
      ),
      'new', JSON_OBJECT(
        'username', NEW.username, 'id_grup', NEW.id_grup, 'pamong_id', NEW.pamong_id,
        'email', NEW.email, 'last_login', NEW.last_login, 'active', NEW.active,
        'nama', NEW.nama, 'phone', NEW.phone, 'foto', NEW.foto
      )
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_login_history`
--

CREATE TABLE `user_login_history` (
  `id` bigint(20) NOT NULL,
  `config_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `login_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Trigger `user_login_history`
--
DELIMITER $$
CREATE TRIGGER `trg_user_login_history_delete` AFTER DELETE ON `user_login_history` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (UUID(), OLD.config_id, 'DELETE', 'user_login_history', OLD.id, JSON_OBJECT('id', OLD.id), 'pending', 0, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_user_login_history_insert` AFTER INSERT ON `user_login_history` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'INSERT', 'user_login_history', NEW.id,
    JSON_OBJECT('user_id', NEW.user_id, 'login_at', NEW.login_at, 'ip_address', NEW.ip_address),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_user_login_history_update` AFTER UPDATE ON `user_login_history` FOR EACH ROW BEGIN
  INSERT INTO inbound_queue (event_id, config_id, event_type, table_name, record_id, payload, status, retry_count, received_at)
  VALUES (
    UUID(), NEW.config_id, 'UPDATE', 'user_login_history', NEW.id,
    JSON_OBJECT(
      'old', JSON_OBJECT('user_id', OLD.user_id, 'login_at', OLD.login_at, 'ip_address', OLD.ip_address),
      'new', JSON_OBJECT('user_id', NEW.user_id, 'login_at', NEW.login_at, 'ip_address', NEW.ip_address)
    ),
    'pending', 0, NOW()
  );
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `artikel`
--
ALTER TABLE `artikel`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `inbound_queue`
--
ALTER TABLE `inbound_queue`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `komentar`
--
ALTER TABLE `komentar`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_login_history`
--
ALTER TABLE `user_login_history`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `artikel`
--
ALTER TABLE `artikel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `inbound_queue`
--
ALTER TABLE `inbound_queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `user_login_history`
--
ALTER TABLE `user_login_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

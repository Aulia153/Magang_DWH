CREATE DATABASE IF NOT EXISTS desa;
USE desa;

-- 1. Membuat Tabel config (Tabel Utama/Master)
CREATE TABLE config (
    id INT AUTO_INCREMENT PRIMARY KEY,
    app_key VARCHAR(100),
    nama_desa VARCHAR(100),
    kode_desa VARCHAR(10),
    kode_desa_bps VARCHAR(10),
    kode_pos INT,
    nama_kecamatan VARCHAR(100),
    kode_kecamatan VARCHAR(6),
    nama_kepala_camat VARCHAR(100),
    nip_kepala_camat VARCHAR(100),
    nama_kabupaten VARCHAR(100),
    kode_kabupaten VARCHAR(4),
    nama_propinsi VARCHAR(100),
    kode_propinsi VARCHAR(2),
    logo VARCHAR(100),
    lat VARCHAR(20),
    lng VARCHAR(20),
    path TEXT,
    alamat_kantor VARCHAR(200),
    telepon VARCHAR(50),
    kantor_desa VARCHAR(100),
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- 2. Membuat Tabel user
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    config_id INT,
    username VARCHAR(100),
    password VARCHAR(100),
    id_grup INT,
    pamong_id INT,
    email VARCHAR(100),
    last_login DATETIME,
    active TINYINT,
    nama VARCHAR(50),
    phone VARCHAR(20),
    foto VARCHAR(100),
    session VARCHAR(40)
);

-- 3. Membuat Tabel user_login_history
CREATE TABLE user_login_history (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    config_id INT,
    user_id INT,
    login_at TIMESTAMP NULL DEFAULT NULL,
    ip_address VARCHAR(45),
    created_at TIMESTAMP NULL DEFAULT NULL
);

-- 4. Membuat Tabel inbound_queue
CREATE TABLE inbound_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id VARCHAR(100),
    config_id INT,
    event_type VARCHAR(20),
    table_name VARCHAR(100),
    record_id INT,
    payload JSON,
    status ENUM('pending', 'success', 'failed', 'retry'),
    retry_count INT,
    error_message TEXT,
    received_at TIMESTAMP NULL DEFAULT NULL,
    processed_at TIMESTAMP NULL DEFAULT NULL
);

-- 5. Membuat Tabel kategori
CREATE TABLE kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    config_id INT,
    kategori VARCHAR(100),
    tipe INT,
    urut TINYINT,
    enabled TINYINT,
    parent INT,
    slug VARCHAR(100)
);

-- 6. Membuat Tabel artikel
CREATE TABLE artikel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    config_id INT,
    gambar VARCHAR(200),
    isi LONGTEXT,
    enabled INT,
    tgl_upload TIMESTAMP NULL DEFAULT NULL,
    id_kategori INT,
    id_user INT,
    judul VARCHAR(200),
    gambar1 VARCHAR(200),
    gambar2 VARCHAR(200),
    gambar3 VARCHAR(200),
    dokumen VARCHAR(400),
    link_dokumen VARCHAR(200),
    boleh_komentar TINYINT,
    slug VARCHAR(200),
    hit INT,
    slider TINYINT
);

-- 7. Membuat Tabel komentar
CREATE TABLE komentar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    config_id INT,
    id_artikel INT,
    owner VARCHAR(50),
    email VARCHAR(50),
    subjek TINYTEXT,
    komentar TEXT,
    tgl_upload TIMESTAMP NULL DEFAULT NULL,
    status TINYINT,
    tipe TINYINT,
    no_hp VARCHAR(15),
    updated_at TIMESTAMP NULL DEFAULT NULL,
    is_archived TINYINT
);
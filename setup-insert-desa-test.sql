INSERT INTO config (
    app_key,
    nama_desa,
    kode_desa,
    kode_desa_bps,
    kode_pos,
    nama_kecamatan,
    kode_kecamatan,
    nama_kepala_camat,
    nip_kepala_camat,
    nama_kabupaten,
    kode_kabupaten,
    nama_propinsi,
    kode_propinsi,
    logo,
    lat,
    lng,
    path,
    alamat_kantor,
    telepon,
    kantor_desa,
    created_at,
    updated_at
) VALUES (
    'APPKEY-SUKAMAJU-001',
    'Desa Sukamaju',
    'sukamaju',
    '3501012001',
    61234,
    'Kecamatan Sukamaju',
    '350101',
    'Budi Santoso',
    '197001011990011001',
    'Kabupaten Sejahtera',
    '3501',
    'Jawa Timur',
    '35',
    'logo.png',
    '-7.257472',
    '112.752090',
    '/var/www/html/desa',
    'Jl. Raya Sukamaju No.1',
    '0311234567',
    'Kantor Desa Sukamaju',
    NOW(),
    NOW()
);

INSERT INTO user (
    config_id,
    username,
    password,
    id_grup,
    pamong_id,
    email,
    last_login,
    active,
    nama,
    phone,
    foto,
    session
) VALUES (
    1,
    'admin',
    'admin123',
    1,
    NULL,
    'admin@sukamaju.id',
    NOW(),
    1,
    'Administrator',
    '081234567890',
    'admin.jpg',
    NULL
);

INSERT INTO kategori (
    config_id,
    kategori,
    tipe,
    urut,
    enabled,
    parent,
    slug
) VALUES
(1,'Berita',1,1,1,0,'berita'),
(1,'Pengumuman',1,2,1,0,'pengumuman'),
(1,'Kegiatan',1,3,1,0,'kegiatan');

INSERT INTO artikel (
    config_id,
    gambar,
    isi,
    enabled,
    tgl_upload,
    id_kategori,
    id_user,
    judul,
    gambar1,
    gambar2,
    gambar3,
    dokumen,
    link_dokumen,
    boleh_komentar,
    slug,
    hit,
    slider
) VALUES
(
    1,
    'berita-1.jpg',
    '<p>Pemerintah Desa Sukamaju meluncurkan website resmi desa.</p>',
    1,
    NOW(),
    1,
    1,
    'Peluncuran Website Desa',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    1,
    'peluncuran-website-desa',
    0,
    1
),
(
    1,
    'pengumuman.jpg',
    '<p>Kerja bakti dilaksanakan hari Minggu pukul 07.00 WIB.</p>',
    1,
    NOW(),
    2,
    1,
    'Pengumuman Kerja Bakti',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    1,
    'pengumuman-kerja-bakti',
    0,
    0
);

INSERT INTO komentar (
    config_id,
    id_artikel,
    owner,
    email,
    subjek,
    komentar,
    tgl_upload,
    status,
    tipe,
    no_hp,
    updated_at,
    is_archived
) VALUES
(
    1,
    1,
    'Andi',
    'andi@example.com',
    'Komentar',
    'Website desa sangat membantu masyarakat.',
    NOW(),
    1,
    1,
    '081234567890',
    NOW(),
    0
),
(
    1,
    2,
    'Budi',
    'budi@example.com',
    'Komentar',
    'Informasi kerja baktinya sangat jelas.',
    NOW(),
    1,
    1,
    '081298765432',
    NOW(),
    0
);

INSERT INTO user_login_history (
    config_id,
    user_id,
    login_at,
    ip_address,
    created_at
) VALUES
(
    1,
    1,
    NOW(),
    '192.168.1.10',
    NOW()
),
(
    1,
    1,
    DATE_SUB(NOW(), INTERVAL 1 DAY),
    '192.168.1.11',
    DATE_SUB(NOW(), INTERVAL 1 DAY)
),
(
    1,
    1,
    DATE_SUB(NOW(), INTERVAL 2 DAY),
    '192.168.1.12',
    DATE_SUB(NOW(), INTERVAL 2 DAY)
);
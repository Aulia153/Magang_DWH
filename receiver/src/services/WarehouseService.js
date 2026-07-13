const pool = require("../config/database");

const TABLE_MAP = {
  config: {
    warehouseTable: "dw_config",
    columns: [
      "app_key",
      "nama_desa",
      "kode_desa_bps",
      "kode_pos",
      "nama_kecamatan",
      "kode_kecamatan",
      "nama_kepala_camat",
      "nip_kepala_camat",
      "nama_kabupaten",
      "kode_kabupaten",
      "nama_propinsi",
      "kode_propinsi",
      "logo",
      "lat",
      "lng",
      "alamat_kantor",
      "telepon",
      "kantor_desa",
    ],
  },
  user: {
    warehouseTable: "dw_user",
    columns: ["username", "id_grup", "pamong_id", "email", "last_login", "active", "nama", "phone", "foto"],
  },
  user_login_history: {
    warehouseTable: "dw_user_login_history",
    columns: ["user_id", "login_at", "ip_address"],
  },
  kategori: {
    warehouseTable: "dw_kategori",
    columns: ["kategori", "tipe", "urut", "enabled", "parent", "slug"],
  },
  artikel: {
    warehouseTable: "dw_artikel",
    columns: [
      "gambar",
      "isi",
      "enabled",
      "tgl_upload",
      "id_kategori",
      "id_user",
      "judul",
      "gambar1",
      "gambar2",
      "gambar3",
      "dokumen",
      "link_dokumen",
      "boleh_komentar",
      "slug",
      "hit",
      "slider",
    ],
  },
  komentar: {
    warehouseTable: "dw_komentar",
    columns: ["id_artikel", "owner", "email", "subjek", "komentar", "tgl_upload", "status", "tipe", "no_hp", "is_archived"],
  },
  // Tabel baru cukup ditambahkan di sini, tidak perlu ubah kode lain
};

class WarehouseService {
  static async apply({ kode_desa, table_name, action, record_id, payload }) {
    const mapping = TABLE_MAP[table_name];

    if (!mapping) {
      throw new Error(`Tabel '${table_name}' belum dipetakan di WarehouseService`);
    }

    if (action === "DELETE") {
      await this.hardDelete(mapping, kode_desa, record_id);
      return;
    }

    if (action === "INSERT") {
      await this.upsert(mapping, kode_desa, record_id, payload);
      return;
    }

    if (action === "UPDATE") {
      const dataForWarehouse = payload.old && payload.new ? payload.new : payload;
      await this.upsert(mapping, kode_desa, record_id, dataForWarehouse);
      return;
    }

    throw new Error(`Action '${action}' tidak dikenali`);
  }

  static async upsert(mapping, kode_desa, record_id, payload) {
    const { warehouseTable, columns } = mapping;

    const values = columns.map((col) => payload[col] ?? null);
    const placeholders = columns.map(() => "?").join(", ");
    const updateClause = columns.map((col) => `${col}=VALUES(${col})`).join(", ");

    await pool.query(
      `
      INSERT INTO ${warehouseTable} (kode_desa, source_id, ${columns.join(", ")})
      VALUES (?, ?, ${placeholders})
      ON DUPLICATE KEY UPDATE ${updateClause}
      `,
      [kode_desa, record_id, ...values],
    );
  }

  static async hardDelete(mapping, kode_desa, record_id) {
    const { warehouseTable } = mapping;

    await pool.query(`DELETE FROM ${warehouseTable} WHERE kode_desa = ? AND source_id = ?`, [kode_desa, record_id]);
  }
}

module.exports = WarehouseService;

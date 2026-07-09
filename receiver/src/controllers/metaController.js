const pool = require("../config/database");

class MetaController {
  static async listDesa(req, res) {
    const [rows] = await pool.query(`SELECT kode_desa, nama_desa FROM desa WHERE status = 'ACTIVE' ORDER BY nama_desa`);
    res.json({ data: rows });
  }

  static async listTables(req, res) {
    const [rows] = await pool.query(`SELECT DISTINCT table_name FROM webhook_logs ORDER BY table_name`);
    res.json({ data: rows.map((r) => r.table_name) });
  }
}

module.exports = MetaController;

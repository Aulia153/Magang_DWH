const pool = require("../config/database");

class LogController {
  static async list(req, res) {
    const { kode_desa, table_name, action, limit = 50, offset = 0 } = req.query;

    const conditions = [];
    const params = [];

    if (kode_desa) {
      conditions.push("kode_desa = ?");
      params.push(kode_desa);
    }
    if (table_name) {
      conditions.push("table_name = ?");
      params.push(table_name);
    }
    if (action) {
      conditions.push("action = ?");
      params.push(action);
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(" AND ")}` : "";

    const [rows] = await pool.query(
      `
  SELECT id, event_id, kode_desa, table_name, action, record_id, payload, status, error_message, received_at, processed_at
  FROM webhook_logs
  ${whereClause}
  ORDER BY received_at DESC
  LIMIT ? OFFSET ?
  `,
      [...params, Number(limit), Number(offset)],
    );

    const parsed = rows.map((row) => ({
      ...row,
      payload: JSON.parse(row.payload),
    }));

    res.json({ data: parsed });
  }
}

module.exports = LogController;

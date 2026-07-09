const pool = require("../config/database");

class LogService {
  static async record({ kode_desa, table_name, action, record_id, payload }) {
    const [result] = await pool.query(
      `
      INSERT INTO webhook_logs (kode_desa, table_name, action, record_id, payload, status)
      VALUES (?, ?, ?, ?, ?, 'RECEIVED')
      `,
      [kode_desa, table_name, action, record_id, JSON.stringify(payload)],
    );

    return result.insertId;
  }

  static async markProcessed(logId) {
    await pool.query(`UPDATE webhook_logs SET status='PROCESSED', processed_at=NOW() WHERE id=?`, [logId]);
  }

  static async markFailed(logId, errorMessage) {
    await pool.query(`UPDATE webhook_logs SET status='FAILED', error_message=?, processed_at=NOW() WHERE id=?`, [errorMessage, logId]);
  }
}

module.exports = LogService;

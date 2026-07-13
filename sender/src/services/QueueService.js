const pool = require("../config/database");

class QueueService {
  static async getPendingQueues(limit = 10) {
    const [rows] = await pool.query(
      `
      SELECT *
      FROM inbound_queue
      WHERE status IN ('pending', 'retry')
      ORDER BY id ASC
      LIMIT ?
      `,
      [limit],
    );

    return rows;
  }

  static async markSuccess(id) {
    await pool.query(
      `
      UPDATE inbound_queue
      SET status = 'success', processed_at = NOW()
      WHERE id = ?
      `,
      [id],
    );
  }

  static async markFailed(id, errorMessage) {
    const [rows] = await pool.query(`SELECT retry_count FROM inbound_queue WHERE id = ?`, [id]);

    if (rows.length === 0) return;

    const retryCount = (rows[0].retry_count || 0) + 1;
    const maxRetry = Number(process.env.MAX_RETRY);

    if (retryCount >= maxRetry) {
      await pool.query(
        `
        UPDATE inbound_queue
        SET status = 'failed', retry_count = ?, error_message = ?, processed_at = NOW()
        WHERE id = ?
        `,
        [retryCount, errorMessage, id],
      );
    } else {
      await pool.query(
        `
        UPDATE inbound_queue
        SET status = 'retry', retry_count = ?, error_message = ?
        WHERE id = ?
        `,
        [retryCount, errorMessage, id],
      );
    }
  }
}

module.exports = QueueService;

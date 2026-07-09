const pool = require("../config/database");

class QueueService {
  static async getPendingQueues(limit = 10) {
    const [rows] = await pool.query(
      `
      SELECT *
      FROM webhook_queue
      WHERE status = 'PENDING'
      ORDER BY id ASC
      LIMIT ?
      `,
      [limit],
    );

    return rows;
  }

  static async markProcessing(id) {
    await pool.query(`UPDATE webhook_queue SET status = 'PROCESSING' WHERE id = ?`, [id]);
  }

  static async markSuccess(id) {
    await pool.query(
      `
      UPDATE webhook_queue
      SET status = 'SUCCESS', processed_at = NOW()
      WHERE id = ?
      `,
      [id],
    );
  }

  static async markFailed(id, errorMessage) {
    const [rows] = await pool.query(`SELECT retry_count FROM webhook_queue WHERE id = ?`, [id]);

    if (rows.length === 0) return;

    const retryCount = rows[0].retry_count + 1;
    const maxRetry = Number(process.env.MAX_RETRY);

    if (retryCount >= maxRetry) {
      await pool.query(
        `
        UPDATE webhook_queue
        SET status = 'FAILED', retry_count = ?, error_message = ?, processed_at = NOW()
        WHERE id = ?
        `,
        [retryCount, errorMessage, id],
      );
    } else {
      await pool.query(
        `
        UPDATE webhook_queue
        SET status = 'PENDING', retry_count = ?, error_message = ?
        WHERE id = ?
        `,
        [retryCount, errorMessage, id],
      );
    }
  }

  static async resetStuckProcessing() {
    await pool.query(`UPDATE webhook_queue SET status = 'PENDING' WHERE status = 'PROCESSING'`);
  }
}

module.exports = QueueService;

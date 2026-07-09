const axios = require("axios");

class WebhookService {
  static async send(queue) {
    const response = await axios.post(
      process.env.WEBHOOK_URL,
      {
        kode_desa: process.env.DESA_KODE,
        table: queue.table_name,
        action: queue.action,
        record_id: queue.record_id,
        payload: JSON.parse(queue.payload), 
      },
      {
        timeout: Number(process.env.WEBHOOK_TIMEOUT),
        headers: {
          Authorization: `Bearer ${process.env.WEBHOOK_TOKEN}`,
          "Content-Type": "application/json",
        },
      },
    );

    return response.data;
  }
}

module.exports = WebhookService;

const axios = require("axios");

class WebhookService {
  static async send(queue) {
    const parsedPayload = typeof queue.payload === "string" ? JSON.parse(queue.payload) : queue.payload;

    const response = await axios.post(
      process.env.WEBHOOK_URL,
      {
        kode_desa: process.env.DESA_KODE,
        event_id: queue.event_id,
        table: queue.table_name,
        action: queue.event_type,
        record_id: queue.record_id,
        payload: parsedPayload,
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

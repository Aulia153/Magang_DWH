const QueueService = require("../services/QueueService");
const WebhookService = require("../services/WebhookService");

class QueueWorker {
  async processQueue(queue) {
    try {
      console.log("----------------------------------");
      console.log(`Queue ID : ${queue.id}`);
      console.log(`Table    : ${queue.table_name}`);
      console.log(`Action   : ${queue.action}`);

      await QueueService.markProcessing(queue.id);
      console.log("Status -> PROCESSING");

      const result = await WebhookService.send(queue);
      console.log("Receiver :", result);

      await QueueService.markSuccess(queue.id);
      console.log("Status -> SUCCESS");
    } catch (err) {
      console.error("Webhook gagal:", err.message);
      await QueueService.markFailed(queue.id, err.message);
    }
  }

  async start() {
    console.log("Queue Worker Started");
    console.log(`Desa   : ${process.env.DESA_KODE}`);
    console.log(`Target : ${process.env.WEBHOOK_URL}`);

    await QueueService.resetStuckProcessing();

    const pollInterval = Number(process.env.POLL_INTERVAL) || 3000;

    while (true) {
      try {
        const queues = await QueueService.getPendingQueues();

        if (queues.length > 0) {
          console.log(`\n${new Date().toLocaleString()}`);
          console.log(`Menemukan ${queues.length} queue`);

          for (const queue of queues) {
            await this.processQueue(queue);
          }
        } else {
          console.log(`${new Date().toLocaleTimeString()} Tidak ada queue.`);
        }
      } catch (err) {
        console.error("Worker error:", err);
      }

      await this.sleep(pollInterval);
    }
  }

  sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}

module.exports = new QueueWorker();

const QueueWorker = require("./workers/QueueWorker");

class App {
  async start() {
    console.log("Sender App Started");
    await QueueWorker.start();
  }
}

module.exports = new App();

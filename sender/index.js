require("dotenv").config();

const app = require("./src/app");

async function bootstrap() {
  try {
    await app.start();
  } catch (err) {
    console.error("Gagal start aplikasi:", err);
    process.exit(1);
  }
}

bootstrap();

const express = require("express");
const cors = require("cors");
const webhookRoutes = require("./routes/webhook");
const logRoutes = require("./routes/logs");
const errorHandler = require("./middlewares/errorHandler");
const metaRoutes = require("./routes/meta");

const app = express();
app.use(cors());
app.use(express.json());
app.use("/api", webhookRoutes);
app.use("/api", logRoutes);
app.use("/api", metaRoutes);

app.use(errorHandler);

module.exports = app;

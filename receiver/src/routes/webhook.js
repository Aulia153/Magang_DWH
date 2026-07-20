const express = require("express");
const authenticate = require("../middlewares/auth");
const WebhookController = require("../controllers/webhookController");

const router = express.Router();

router.post("/webhook", authenticate, WebhookController.receive);

module.exports = router;


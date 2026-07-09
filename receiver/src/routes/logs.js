const express = require("express");
const LogController = require("../controllers/logController");

const router = express.Router();

router.get("/logs", LogController.list);

module.exports = router;

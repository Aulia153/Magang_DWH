const express = require("express");
const MetaController = require("../controllers/metaController");

const router = express.Router();

router.get("/desa", MetaController.listDesa);
router.get("/tables", MetaController.listTables);

module.exports = router;

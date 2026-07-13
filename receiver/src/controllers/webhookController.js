const LogService = require("../services/LogService");
const WarehouseService = require("../services/WarehouseService");

class WebhookController {
  static async receive(req, res) {
    const { event_id, table, action, record_id, payload } = req.body;
    const kode_desa = req.desa.kode_desa;

    if (!table || !action || record_id === undefined) {
      return res.status(400).json({ message: "Field table, action, record_id wajib diisi" });
    }

    const logId = await LogService.record({
      eventId: event_id,
      kode_desa,
      table_name: table,
      action,
      record_id,
      payload,
    });

    res.status(200).json({ message: "Diterima", log_id: logId });

    try {
      await WarehouseService.apply({ kode_desa, table_name: table, action, record_id, payload });
      await LogService.markProcessed(logId);
      console.log(`[${kode_desa}] ${action} ${table} #${record_id} -> PROCESSED`);
    } catch (err) {
      await LogService.markFailed(logId, err.message);
      console.error(`[${kode_desa}] ${action} ${table} #${record_id} -> FAILED: ${err.message}`);
    }
  }
}

module.exports = WebhookController;

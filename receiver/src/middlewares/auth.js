const pool = require("../config/database");

async function authenticate(req, res, next) {
  const authHeader = req.headers.authorization || "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : null;

  if (!token) {
    return res.status(401).json({ message: "Token tidak ditemukan" });
  }

  try {
    const [rows] = await pool.query(`SELECT id, kode_desa, nama_desa, status FROM desa WHERE api_token = ?`, [token]);

    if (rows.length === 0) {
      return res.status(401).json({ message: "Token tidak valid" });
    }

    const desa = rows[0];

    if (desa.status !== "ACTIVE") {
      return res.status(403).json({ message: `Desa ${desa.kode_desa} tidak aktif` });
    }

    // Simpan info desa di request, dipakai controller berikutnya
    req.desa = desa;
    next();
  } catch (err) {
    next(err);
  }
}

module.exports = authenticate;

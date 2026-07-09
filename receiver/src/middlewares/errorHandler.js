function errorHandler(err, req, res, next) {
  console.error("Unhandled error:", err);
  res.status(500).json({ message: "Terjadi kesalahan pada server" });
}

module.exports = errorHandler;

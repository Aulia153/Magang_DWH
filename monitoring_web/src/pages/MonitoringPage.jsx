import { useCallback, useEffect, useRef, useState } from "react";
import FilterBar from "../components/FilterBar";
import LogTable from "../components/LogTable";
import Pagination from "../components/Pagination";
import { fetchLogs } from "../services/logService";

const LIMIT = 20;
const POLL_INTERVAL = Number(import.meta.env.VITE_POLL_INTERVAL) || 5000;

function MonitoringPage() {
  const [filters, setFilters] = useState({});
  const [offset, setOffset] = useState(0);
  const [logs, setLogs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [autoRefresh, setAutoRefresh] = useState(true);
  const [lastUpdated, setLastUpdated] = useState(null);

  const filtersRef = useRef(filters);
  const offsetRef = useRef(offset);
  filtersRef.current = filters;
  offsetRef.current = offset;

  const loadLogs = useCallback(async ({ silent = false } = {}) => {
    if (!silent) setLoading(true);
    setError(null);

    try {
      const data = await fetchLogs({ ...filtersRef.current, limit: LIMIT, offset: offsetRef.current });
      setLogs(data);
      setLastUpdated(new Date());
    } catch (err) {
      if (!silent) setError("Gagal mengambil data monitoring. Pastikan server receiver berjalan.");
    } finally {
      if (!silent) setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadLogs();
  }, [filters, offset, loadLogs]);

  useEffect(() => {
    if (!autoRefresh || offset !== 0) return;

    const interval = setInterval(() => {
      loadLogs({ silent: true });
    }, POLL_INTERVAL);

    return () => clearInterval(interval);
  }, [autoRefresh, offset, loadLogs]);

  function handleApplyFilters(newFilters) {
    setFilters(newFilters);
    setOffset(0);
  }

  return (
    <div className="flex h-screen flex-col overflow-hidden bg-slate-100 px-4 py-6 sm:px-6 lg:px-10">
      <div className="mx-auto flex w-full max-w-6xl flex-1 flex-col gap-4 overflow-hidden">
        {/* Zona tetap: tidak ikut scroll */}
        <header className="flex shrink-0 flex-wrap items-center justify-between gap-3">
          <div>
            <h1 className="text-xl font-semibold text-slate-900">Monitoring sinkronisasi data desa</h1>
            <p className="mt-1 text-sm text-slate-500">Riwayat perubahan data yang masuk dari seluruh desa ke database induk.</p>
          </div>

          <div className="flex items-center gap-3 text-xs text-slate-500">
            {lastUpdated && <span>Diperbarui {lastUpdated.toLocaleTimeString("id-ID")}</span>}
            <button
              onClick={() => setAutoRefresh((prev) => !prev)}
              className={`flex items-center gap-1.5 rounded-full px-3 py-1 font-medium ${
                autoRefresh ? "bg-emerald-100 text-emerald-700" : "bg-slate-200 text-slate-500"
              }`}
            >
              <span className={`h-1.5 w-1.5 rounded-full ${autoRefresh ? "bg-emerald-500 animate-pulse" : "bg-slate-400"}`} />
              {autoRefresh ? "Live" : "Jeda"}
            </button>
          </div>
        </header>

        <div className="shrink-0">
          <FilterBar onApply={handleApplyFilters} />
        </div>

        {error && <div className="shrink-0 rounded-md border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-600">{error}</div>}

        {/* Zona fleksibel: satu-satunya yang scroll sendiri */}
        <div className="min-h-0 flex-1">
          <LogTable logs={logs} loading={loading} />
        </div>

        {/* Zona tetap: tidak ikut scroll */}
        <div className="shrink-0">
          <Pagination
            offset={offset}
            limit={LIMIT}
            count={logs.length}
            onPrev={() => setOffset((prev) => Math.max(0, prev - LIMIT))}
            onNext={() => setOffset((prev) => prev + LIMIT)}
          />
        </div>
      </div>
    </div>
  );
}

export default MonitoringPage;

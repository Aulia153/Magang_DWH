import StatusBadge from "./StatusBadge";
import PayloadDetail from "./PayloadDetail";

function formatDate(value) {
  return new Date(value).toLocaleString("id-ID", { dateStyle: "medium", timeStyle: "short" });
}

function QueueTable({ logs, loading }) {
  if (loading) {
    return <p className="py-10 text-center text-sm text-slate-400">Memuat data...</p>;
  }

  if (logs.length === 0) {
    return <p className="py-10 text-center text-sm text-slate-400">Tidak ada data antrian untuk filter ini.</p>;
  }

  return (
    <div className="divide-y divide-slate-100">
      {logs.map((log) => (
        <div key={log.id} className="p-4 sm:p-6">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div className="flex flex-wrap items-center gap-2">
              <span className="text-sm font-semibold text-slate-800">{log.table_name}</span>
              <span className="text-xs text-slate-400">#{log.record_id ?? "-"}</span>
              <StatusBadge value={log.action} />
              <StatusBadge value={log.status} />
            </div>

            <div className="text-right text-xs text-slate-500">
              <p>{log.kode_desa}</p>
              <p>{formatDate(log.received_at)}</p>
            </div>
          </div>

          {log.event_id && <p className="mt-2 font-mono text-[11px] text-slate-400">Event ID: {log.event_id}</p>}

          {log.status === "FAILED" && log.error_message && (
            <p className="mt-2 rounded-md bg-rose-50 px-3 py-2 text-xs font-medium text-rose-600">Error: {log.error_message}</p>
          )}

          <div className="mt-3 overflow-x-auto rounded-lg border border-slate-100">
            <PayloadDetail action={log.action} payload={log.payload} />
          </div>
        </div>
      ))}
    </div>
  );
}

export default QueueTable;

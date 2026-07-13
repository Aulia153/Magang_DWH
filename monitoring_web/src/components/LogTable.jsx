import { Fragment, useState } from "react";
import StatusBadge from "./StatusBadge";
import PayloadDetail from "./PayloadDetail";

function formatDate(value) {
  return new Date(value).toLocaleString("id-ID", { dateStyle: "medium", timeStyle: "short" });
}

function LogTable({ logs, loading }) {
  const [expandedId, setExpandedId] = useState(null);

  if (loading) {
    return (
      <div className="flex h-full items-center justify-center rounded-lg border border-slate-200 bg-white">
        <p className="text-sm text-slate-400">Memuat data...</p>
      </div>
    );
  }

  if (logs.length === 0) {
    return (
      <div className="flex h-full items-center justify-center rounded-lg border border-slate-200 bg-white">
        <p className="text-sm text-slate-400">Tidak ada data untuk filter ini.</p>
      </div>
    );
  }

  return (
    <div className="flex h-full flex-col overflow-hidden rounded-lg border border-slate-200 bg-white">
      <div className="flex-1 overflow-y-auto overflow-x-auto">
        <table className="w-full text-left text-sm">
          <thead className="sticky top-0 z-10 bg-slate-50 text-xs uppercase text-slate-500 shadow-[0_1px_0_0_rgb(226,232,240)]">
            <tr>
              <th className="px-4 py-2.5">Waktu</th>
              <th className="px-4 py-2.5">Desa</th>
              <th className="px-4 py-2.5">Tabel</th>
              <th className="px-4 py-2.5">ID</th>
              <th className="px-4 py-2.5">Aksi</th>
              <th className="px-4 py-2.5">Status</th>
              <th className="px-4 py-2.5"></th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-100">
            {logs.map((log) => (
              <Fragment key={log.id}>
                <tr className="hover:bg-slate-50">
                  <td className="whitespace-nowrap px-4 py-2.5 text-slate-500">{formatDate(log.received_at)}</td>
                  <td className="px-4 py-2.5 font-medium text-slate-700">{log.kode_desa}</td>
                  <td className="px-4 py-2.5 text-slate-600">{log.table_name}</td>
                  <td className="px-4 py-2.5 text-slate-500">#{log.record_id ?? "-"}</td>
                  <td className="px-4 py-2.5">
                    <StatusBadge value={log.action} />
                  </td>
                  <td className="px-4 py-2.5">
                    <StatusBadge value={log.status} />
                  </td>
                  <td className="px-4 py-2.5 text-right">
                    <button
                      onClick={() => setExpandedId(expandedId === log.id ? null : log.id)}
                      className="text-xs font-medium text-slate-500 hover:text-slate-900"
                    >
                      {expandedId === log.id ? "Tutup" : "Detail"}
                    </button>
                  </td>
                </tr>

                {expandedId === log.id && (
                  <tr>
                    <td colSpan={7} className="bg-slate-50 px-4 py-3">
                      {log.event_id && <p className="mb-2 font-mono text-[11px] text-slate-400">Event ID: {log.event_id}</p>}
                      {log.status === "FAILED" && log.error_message && (
                        <p className="mb-2 text-xs font-medium text-rose-600">Error: {log.error_message}</p>
                      )}
                      <PayloadDetail action={log.action} payload={log.payload} />
                    </td>
                  </tr>
                )}
              </Fragment>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default LogTable;

import { useState } from "react";
import StatusBadge from "./StatusBadge";
import DetailModal from "./DetailModal";
import { formatTableName } from "../utils/formatText";

const BODY_HEIGHT = 224;
const TABLE_MAX_HEIGHT = 268;

function formatDate(value) {
  return new Date(value).toLocaleString("id-ID", {
    dateStyle: "medium",
    timeStyle: "short",
  });
}

function LogTable({ logs, loading }) {
  const [selectedLog, setSelectedLog] = useState(null);

  return (
    <>
      <div className="overflow-auto" style={{ maxHeight: loading || logs.length === 0 ? undefined : TABLE_MAX_HEIGHT }}>
        <table className="w-full min-w-170 border-collapse text-left text-sm">
          <thead className="sticky top-0 z-10 bg-slate-50 shadow-sm">
            <tr className="border-b border-slate-200">
              <th className="px-3 py-3 sm:px-4">Waktu</th>
              <th className="px-3 py-3 sm:px-4">Desa</th>
              <th className="px-3 py-3 sm:px-4">Tabel</th>
              <th className="hidden px-3 py-3 sm:table-cell sm:px-4">ID</th>
              <th className="px-3 py-3 sm:px-4">Aksi</th>
              <th className="px-3 py-3 sm:px-4">Status</th>
              <th className="px-3 py-3 text-right sm:px-4">Info</th>
            </tr>
          </thead>

          <tbody className="divide-y divide-slate-100">
            {loading && (
              <tr>
                <td colSpan={7} style={{ height: BODY_HEIGHT }} className="px-4 text-center">
                  <div className="flex h-full flex-col items-center justify-center gap-3">
                    <svg className="h-8 w-8 animate-spin text-slate-300" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" />
                    </svg>
                    <p className="text-sm text-slate-400">Memuat data...</p>
                  </div>
                </td>
              </tr>
            )}

            {!loading && logs.length === 0 && (
              <tr>
                <td colSpan={7} style={{ height: BODY_HEIGHT }} className="px-4 text-center">
                  <div className="flex h-full flex-col items-center justify-center gap-2">
                    <svg className="h-12 w-12 text-slate-300" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={1.5}>
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z"
                      />
                    </svg>
                    <p className="text-sm font-medium text-slate-500">Tidak ada data untuk filter ini</p>
                    <p className="text-xs text-slate-400">Coba ubah filter atau tunggu event sinkronisasi berikutnya.</p>
                  </div>
                </td>
              </tr>
            )}

            {!loading &&
              logs.map((log) => (
                <tr key={log.id} className="transition hover:bg-slate-50">
                  <td className="whitespace-nowrap px-3 py-3 text-slate-500 sm:px-4">{formatDate(log.received_at)}</td>

                  <td className="px-3 py-3 font-medium sm:px-4">{log.kode_desa}</td>

                  <td className="px-3 py-3 sm:px-4">{formatTableName(log.table_name)}</td>

                  <td className="hidden px-3 py-3 sm:table-cell sm:px-4">#{log.record_id ?? "-"}</td>

                  <td className="px-3 py-3 sm:px-4">
                    <StatusBadge value={log.action} />
                  </td>

                  <td className="px-3 py-3 sm:px-4">
                    <StatusBadge value={log.status} />
                  </td>

                  <td className="px-3 py-3 text-right sm:px-4">
                    <button
                      onClick={() => setSelectedLog(log)}
                      className="rounded-md border border-slate-300 px-3 py-1 text-xs font-medium hover:bg-slate-100"
                    >
                      Detail
                    </button>
                  </td>
                </tr>
              ))}
          </tbody>
        </table>
      </div>

      <DetailModal log={selectedLog} onClose={() => setSelectedLog(null)} />
    </>
  );
}

export default LogTable;

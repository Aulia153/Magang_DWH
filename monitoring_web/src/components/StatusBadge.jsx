const STYLES = {
  INSERT: "bg-emerald-100 text-emerald-700",
  UPDATE: "bg-amber-100 text-amber-700",
  DELETE: "bg-rose-100 text-rose-700",
  RECEIVED: "bg-slate-100 text-slate-700",
  PROCESSED: "bg-emerald-100 text-emerald-700",
  FAILED: "bg-rose-100 text-rose-700",
};

function StatusBadge({ value }) {
  const style = STYLES[value] || "bg-slate-100 text-slate-700";

  return <span className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium ${style}`}>{value}</span>;
}

export default StatusBadge;

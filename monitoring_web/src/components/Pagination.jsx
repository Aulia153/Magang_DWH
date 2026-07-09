function Pagination({ offset, limit, count, onPrev, onNext }) {
  const page = Math.floor(offset / limit) + 1;
  const hasPrev = offset > 0;
  const hasNext = count === limit; // kalau hasil penuh, kemungkinan masih ada halaman berikutnya

  return (
    <div className="flex items-center justify-between px-1 text-sm text-slate-500">
      <span>Halaman {page}</span>
      <div className="flex gap-2">
        <button
          disabled={!hasPrev}
          onClick={onPrev}
          className="rounded-md border border-slate-300 px-3 py-1 text-xs font-medium text-slate-600 hover:bg-slate-50 disabled:opacity-40"
        >
          Sebelumnya
        </button>
        <button
          disabled={!hasNext}
          onClick={onNext}
          className="rounded-md border border-slate-300 px-3 py-1 text-xs font-medium text-slate-600 hover:bg-slate-50 disabled:opacity-40"
        >
          Berikutnya
        </button>
      </div>
    </div>
  );
}

export default Pagination;

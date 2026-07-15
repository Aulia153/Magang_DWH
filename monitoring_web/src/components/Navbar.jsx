import { useEffect, useState } from "react";
import { CircleUser } from "lucide-react";

function Navbar({ autoRefresh, isOnline }) {
  const [now, setNow] = useState(new Date());

  useEffect(() => {
    const interval = setInterval(() => {
      setNow(new Date());
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  return (
    <nav className="sticky top-0 z-50 border-b border-slate-200 bg-white shadow-sm">
      <div className="mx-auto flex h-16 max-w-7xl items-center justify-between gap-2 px-3 sm:px-6">
        <div className="flex min-w-0 items-center gap-2 sm:gap-3">
          <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md bg-blue-900 text-sm font-bold text-white sm:h-10 sm:w-10 sm:text-lg">
            M
          </div>

          <div className="min-w-0">
            <h1 className="truncate text-sm font-semibold text-blue-900 sm:text-lg">Monitoring Sinkronisasi Desa</h1>

            <p className="hidden text-xs text-slate-500 sm:block">Sistem Monitoring Webhook OpenSID</p>
          </div>
        </div>

        <div className="flex shrink-0 items-center gap-2 text-xs sm:gap-6 sm:text-sm">
          <div className="hidden items-center gap-2 sm:flex">
            <span className={`h-2.5 w-2.5 rounded-full ${isOnline ? "animate-pulse bg-green-500" : "bg-red-500"}`}></span>
            <span className={`font-medium ${isOnline ? "text-green-600" : "text-red-600"}`}>{isOnline ? "Receiver Online" : "Receiver Offline"}</span>
          </div>

          <span className={`h-2 w-2 rounded-full sm:hidden ${isOnline ? "animate-pulse bg-green-500" : "bg-red-500"}`}></span>

          <div className="hidden font-mono text-slate-500 md:block">{now.toLocaleTimeString("id-ID")}</div>

          <div
            className={`rounded-full px-2 py-1 text-[10px] font-semibold sm:px-3 sm:text-xs ${
              autoRefresh && isOnline ? "bg-green-100 text-green-700" : "bg-slate-200 text-slate-600"
            }`}
          >
            {autoRefresh && isOnline ? "LIVE" : "PAUSED"}
          </div>

          <div className="flex items-center gap-2">
            <CircleUser className="h-7 w-7 text-slate-400 sm:h-8 sm:w-8" />
            <span className="hidden lg:block font-medium text-slate-700">Administrator</span>
          </div>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;

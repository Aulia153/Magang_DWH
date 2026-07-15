import { Link, useLocation } from "react-router-dom";

const TABS = [
  { label: "Monitoring", path: "/" },
  { label: "Riwayat Login", path: "/riwayat-login" },
  { label: "Log Aktivitas", path: "/log-aktivitas" },
];

function TabMenu() {
  const location = useLocation();

  return (
    <div className="sticky top-16 z-40 border-b border-slate-200 bg-white shadow-sm">
      <div className="mx-auto flex max-w-7xl gap-6 overflow-x-auto px-4 sm:gap-8 sm:px-6">
        {TABS.map((tab) => {
          const isActive = location.pathname === tab.path;

          return (
            <Link
              key={tab.path}
              to={tab.path}
              className={`whitespace-nowrap cursor-pointer border-b-2 px-1 py-4 text-sm font-semibold transition ${
                isActive ? "border-blue-900 text-blue-900" : "border-transparent text-slate-500 hover:text-slate-700"
              }`}
            >
              {tab.label}
            </Link>
          );
        })}
      </div>
    </div>
  );
}

export default TabMenu;

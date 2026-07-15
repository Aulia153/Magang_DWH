import { Routes, Route } from "react-router-dom";
import MonitoringPage from "./pages/MonitoringPage";
import LoginHistoryPage from "./pages/LoginHistoryPage";
import ActivityLog from "./pages/ActivityLog";

function App() {
  return (
    <Routes>
      <Route path="/" element={<MonitoringPage />} />
      <Route path="/riwayat-login" element={<LoginHistoryPage />} />
      <Route path="/log-aktivitas" element={<ActivityLog />} />
    </Routes>
  );
}

export default App;

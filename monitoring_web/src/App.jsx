import { Routes, Route } from "react-router-dom";
import MonitoringPage from "./pages/MonitoringPage";

function App() {
  return (
    <Routes>
      <Route path="/" element={<MonitoringPage />} />
    </Routes>
  );
}

export default App;

import React, { useEffect, useState } from "react";
import axios from "axios";
import { Bar } from "react-chartjs-2";
import {
  Chart as ChartJS,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(BarElement, CategoryScale, LinearScale);

function App() {
  const [data, setData] = useState(null);

  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/dashboard/")
      .then(res => setData(res.data))
      .catch(err => console.log(err));
  }, []);

  if (!data) return <h2 style={{padding: "20px"}}>Loading Dashboard...</h2>;

  const chartData = {
    labels: data.monthly_revenue.map(item => item.month),
    datasets: [
      {
        label: "Monthly Revenue",
        data: data.monthly_revenue.map(item => item.revenue),
        backgroundColor: "rgba(75,192,192,0.6)"
      }
    ]
  };

  return (
    <div style={{ padding: "40px", fontFamily: "Arial" }}>
      <h1>Ecommerce Analytics Dashboard</h1>

      <h2>Total Revenue: ₹{data.total_revenue}</h2>
      <h2>Total Orders: {data.total_orders}</h2>

      <div style={{ width: "600px", margin: "40px 0" }}>
        <Bar data={chartData} />
      </div>

      <h3>Top Products</h3>
      <ul>
        {data.top_products.map((product, index) => (
          <li key={index}>
            {product.name} - {product.sales} sales
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
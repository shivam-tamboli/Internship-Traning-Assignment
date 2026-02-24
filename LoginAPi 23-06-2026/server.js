const express = require("express");
const path = require("path");

const app = express();
const PORT = 3000;

// Middleware to read JSON
app.use(express.json());

// Serve static files
app.use(express.static(path.join(__dirname, "public")));

// Routes
const authRoutes = require("./routes/auth");
app.use("/api", authRoutes);

// Start server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
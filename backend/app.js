const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const otpRoutes = require("./routes/Otp");

const app = express(); // ✅ MUST come before app.use()

// Load env variables
dotenv.config();

// Middleware
app.use(express.json());

// Routes
app.use("/api", otpRoutes);

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log("✅ Connected to MongoDB Atlas");
    app.listen(5000, () => {
      console.log("🚀 Server running on http://localhost:5000");
    });
  })
  .catch((err) => {
    console.error("❌ MongoDB connection error:", err);
  });

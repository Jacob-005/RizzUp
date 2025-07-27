const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const otpRoutes = require("./routes/Otp");
const authRoutes = require("./routes/auth");

const app = express();

// Load env variables
dotenv.config();

// Middleware
app.use(express.json());

// Routes
app.use("/api", otpRoutes);
app.use("/api", authRoutes);

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log("Connected to MongoDB Atlas");
    app.listen(5000, () => {
      console.log("🚀 Server running on http://localhost:5000");
    });
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
  });

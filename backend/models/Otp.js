const mongoose = require("mongoose");

const otpSchema = new mongoose.Schema({
  targetType: {
    type: String,
    enum: ["email", "phone"], // Specifies the OTP type
    required: true
  },
  identifier: {
    type: String, // Can be a phone number or email address
    required: true
  },
  otp: {
    type: String, // The 4-digit OTP code
    required: true
  },
  expiresAt: {
    type: Date, // When the OTP should expire
    required: true
  },
  verified: {
    type: Boolean,
    default: false // Will be true after successful verification
  }
}, {
  timestamps: true // Adds createdAt and updatedAt fields automatically
});

module.exports = mongoose.model("Otp", otpSchema);

const express = require("express");
const router = express.Router();
const Otp = require("../models/Otp");

// Utility function to generate 4-digit OTP
function generateOtp() {
  return Math.floor(1000 + Math.random() * 9000).toString();
}

// College domain you want to accept (customize as needed)
const ALLOWED_COLLEGE_DOMAIN = "@stvincentngp.edu.in";

// POST /send-otp
router.post("/send-otp", async (req, res) => {
  try {
    const { identifier, targetType } = req.body;

    // 1. Basic input validation
    if (!identifier || !targetType) {
      return res.status(400).json({ error: "identifier and targetType are required" });
    }

    if (!["email", "phone"].includes(targetType)) {
      return res.status(400).json({ error: "targetType must be 'email' or 'phone'" });
    }

    // 2. For email, check if it's a valid college email
    if (targetType === "email" && !identifier.endsWith(ALLOWED_COLLEGE_DOMAIN)) {
      return res.status(400).json({ error: "Only college email addresses are allowed" });
    }

    // 3. Prevent spamming: check for existing OTP (unverified + not expired)
    const existingOtp = await Otp.findOne({
      identifier,
      targetType,
      verified: false,
      expiresAt: { $gt: new Date() } // Not expired yet
    });

    if (existingOtp) {
      return res.status(429).json({ error: "OTP already sent. Try again later." });
    }

    // 4. Generate OTP and expiry
   // 1. Generate 4-digit OTP
    const otpCode = Math.floor(1000 + Math.random() * 9000).toString();

    // 2. Set expiration time (5 minutes from now)
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000);

    // 3. Create new OTP entry
    const otpEntry = new Otp({
      identifier,
      targetType,
      otp: otpCode,
      expiresAt
    });

    await otpEntry.save();

    new Date(Date.now() + 3 * 60 * 1000) // expires in 3 minutes

    // 5. Save to database
    const otp = new Otp({
      identifier,
      targetType,
      otp: otpCode,
      expiresAt,
    });

    await otp.save();

    // TODO: Send OTP using email or SMS here

    return res.status(200).json({ message: "OTP sent successfully", otp: otpCode }); // dev only: include OTP
  } catch (err) {
    console.error("Error in /send-otp:", err);
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;


// Verify OTP Route
router.post("/verify-otp", async (req, res) => {
  const { identifier, targetType, otp } = req.body;

  if (!identifier || !targetType || !otp) {
    return res.status(400).json({ error: "All fields are required" });
  }

  try {
    // Find the latest unverified OTP for the given identifier & type
    const record = await Otp.findOne({
      identifier,
      targetType,
      verified: false
    }).sort({ createdAt: -1 });

    if (!record) {
      return res.status(404).json({ error: "OTP not found or already verified" });
    }

    if (record.expiresAt < new Date()) {
      return res.status(400).json({ error: "OTP has expired" });
    }

    if (record.otp !== otp) {
      return res.status(401).json({ error: "Invalid OTP" });
    }

    // Mark as verified
    record.verified = true;
    await record.save();

    return res.status(200).json({ message: "OTP verified successfully ✅" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error while verifying OTP" });
  }
});


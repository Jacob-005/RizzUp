const express = require("express");
const router = express.Router();
const Otp = require("../models/Otp");
const { sendEmailOtp } = require("../utils/mailer");
// const { sendSmsOtp } = require("../utils/sms");

// College email domain restriction
const ALLOWED_COLLEGE_DOMAIN = "@stvincentngp.edu.in";
// const ALLOWED_COLLEGE_DOMAIN = "@iilm.edu";

// Utility to validate email
function isValidEmail(email) {
  const re = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
  return re.test(email);
}

// Utility to generate 4-digit OTP
function generateOtp() {
  return Math.floor(1000 + Math.random() * 9000).toString();
}

// ✅ SEND OTP
router.post("/send-otp", async (req, res) => {
  try {
    const { identifier, targetType } = req.body;

    if (!identifier || !targetType) {
      return res.status(400).json({ error: "Missing identifier or targetType" });
    }

    if (!["email", "phone"].includes(targetType)) {
      return res.status(400).json({ error: "targetType must be 'email' or 'phone'" });
    }

    // Validate email structure & domain
    if (targetType === "email") {
      if (!isValidEmail(identifier)) {
        return res.status(400).json({ error: "Invalid email format" });
      }
      if (!identifier.endsWith(ALLOWED_COLLEGE_DOMAIN)) {
        return res.status(400).json({ error: "Only college email addresses are allowed" });
      }
    }

    // // Prevent OTP spamming
    // const existingOtp = await Otp.findOne({
    //   identifier,
    //   targetType,
    //   verified: false,
    //   expiresAt: { $gt: new Date() }
    // });

    // if (existingOtp) {
    //   return res.status(429).json({ error: "OTP already sent. Try again later." });
    // }

    // Generate new OTP
    const otpCode = generateOtp();
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes from now

    // Save OTP to database
    await Otp.findOneAndUpdate(
      { identifier, targetType },
      {
        otp: otpCode,
        verified: false,
        expiresAt,
      },
      { upsert: true, new: true }
    );
    // console.log("✅ OTP stored in DB:", savedOtp);

    // Send OTP
     if (targetType === "email") {
      const emailSent = await sendEmailOtp(identifier, otpCode);
      if (!emailSent) {
        return res.status(500).json({ error: "Failed to send OTP email" });
      }
    } else {
      console.log("📲 Simulating SMS OTP send:", otpCode);
    }

    return res.status(200).json({ message: "OTP sent successfully ✅" });
  } catch (err) {
    console.error("❌ Error in /send-otp:", err);
    return res.status(500).json({ error: "Server error" });
  }
});

// ✅ VERIFY OTP
router.post("/verify-otp", async (req, res) => {
  try {
    const { identifier, targetType, otp } = req.body;

    if (!identifier || !targetType || !otp) {
      return res.status(400).json({ error: "All fields are required" });
    }

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

    // Mark OTP as verified
    record.verified = true;
    await record.save();

    return res.status(200).json({ message: "OTP verified successfully ✅" });
  } catch (err) {
    console.error("❌ Error in /verify-otp:", err);
    return res.status(500).json({ error: "Server error while verifying OTP" });
  }
});

module.exports = router;

const express = require("express");
// const bcrypt = require("bcryptjs");
const router = express.Router();

const User = require("../models/User");
const Otp = require("../models/Otp"); // to verify OTP

// Register route
router.post("/register", async (req, res) => {
  try {
    const {
      firstName,
      lastName,
      course,
      dob,
      email,
      phone,
      gender,
      sex,
    //   password
    } = req.body;

    // 1. Check email OTP is verified
    const verifiedEmail = await Otp.findOne({
      identifier: email,
      targetType: "email",
      verified: true
    });

    // 2. Check phone OTP is verified
    const verifiedPhone = await Otp.findOne({
      identifier: phone,
      targetType: "phone",
      verified: true
    });

    if (!verifiedEmail) {
      return res.status(400).json({ error: "Email OTP not verified" });
    }

    if(!verifiedPhone){
        return res.status(400).json({ error: "Phone OTP not verified" });
    }

    // 3. Check if user already exists
    const existingUser = await User.findOne({ $or: [{ email }, { phone }] });
    if (existingUser) {
      return res.status(400).json({ error: "User already exists" });
    }

    // // 4. Hash the password
    // const salt = await bcrypt.genSalt(10);
    // const hashedPassword = await bcrypt.hash(password, salt);

    // 5. Create the user
    const newUser = new User({
      firstName,
      lastName,
      course,
      dob,
      email,
      emailVerified: true,
      phone,
      phoneVerified: true,
      gender,
      sex,
    //   password: hashedPassword
    });

    await newUser.save();

    res.status(201).json({ message: "User registered successfully ✅" });
  } catch (err) {
    console.error("Registration error:", err);
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;

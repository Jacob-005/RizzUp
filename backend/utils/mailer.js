const nodemailer = require("nodemailer");
require("dotenv").config();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS, // App password, not your Gmail password
  },
});

const sendEmailOtp = async (to, otp) => {
  const mailOptions = {
    from: `"RizzUp OTP" <${process.env.EMAIL_USER}>`,
    to,
    subject: "Your RizzUp OTP",
    text: `Hello,
    ${otp} is you RizzUp OTP.
    Please do not share this OTP with anyone.
    This OTP is valid for 5 minutes.
    If you did not request this OTP, please ignore this email.
    Thank you,
    RizzUp Team`,
  };

  try {
    const info = await transporter.sendMail(mailOptions);
    console.log("✅ Email sent:", info.response);
    return true;
  } catch (err) {
    console.error("❌ Failed to send email:", err); // <-- ADD THIS LINE
    return false;
  }
};

module.exports = { sendEmailOtp };

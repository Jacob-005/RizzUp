const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  firstName: { type: String, required: true },
  lastName: { type: String, required: true },
  course: { type: String },
  dob: { type: Date },
  email: { type: String, required: true, unique: true },
  emailVerified: { type: Boolean, default: false },
  gender: { type: String },
  sex: { type: String },
  phone: { type: String, required: true, unique: true },
  phoneVerified: { type: Boolean, default: false },
  basicInfo: { type: [String], default: [] },
  interests: { type: [String], default: [] },
  photos: { type: [String], default: [] },
  musicInterests: { type: [String], default: [] },
  audioRecordings: { type: [String], default: [] },
  rightSwipes: { type: [mongoose.Schema.Types.ObjectId], ref: "User", default: [] },
  leftSwipes: { type: [mongoose.Schema.Types.ObjectId], ref: "User", default: [] },
  matches: { type: [mongoose.Schema.Types.ObjectId], ref: "User", default: [] }
}, { timestamps: true });

const User = mongoose.model("User", userSchema);
module.exports = User;
module.exports = mongoose.model("User", userSchema);
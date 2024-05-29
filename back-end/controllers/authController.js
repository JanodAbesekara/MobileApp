import bcrypt from "bcryptjs";
import User from "../models/usermodel.js";
import {
  sendForgotPasswordEmail,
  sendVerificationEmail,
} from "../config/sendEmails.js";
import tokengenerator from "../config/createToken.js";

const registerController = async (req, res) => {
  const { firstname, lastname, phonenumber, email, role, password } = req.body;

  const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

  if (!firstname || !lastname || !phonenumber || !email || !role || !password) {
    return res
      .status(400)
      .json({ success: false, msg: "Please fill in all the fields" });
  }

  if (!emailRegex.test(email)) {
    return res
      .status(400)
      .json({ success: false, msg: "Please enter a valid email" });
  }
  if (
    password.length < 8 &&
    ![A - Z].test(password) &&
    ![a - z].test(password) &&
    ![0 - 9].test(password) &&
    !/[!@#$%^&*()_\-+=\[\]{};':"\\|,.<>\/?]/.test(password)
  ) {
    return res.status(400).json({
      success: false,
      msg: "Please enter a valid password with at least 8 characters, one uppercase letter, one lowercase letter, one number and one special character",
    });
  }

  try {
    const oldUser = await User.findOne({ email });
    if (oldUser) {
      return res
        .status(403)
        .json({ success: false, msg: "User already exists" });
    }

    const salt = await bcrypt.genSalt(12);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newUser = new User({
      firstname,
      lastname,
      phonenumber,
      role,
      email,
      password: hashedPassword,
    });

    await newUser.save();

    // generated token
    const token = tokengenerator({ email: newUser.email });
    const link = "http://" + req.hostname + ":3000/VerifyEmail?token=" + token;

    const sendMail = await sendVerificationEmail(newUser.email, link);

    if (sendMail) {
      return res.status(201).json({
        success: true,
        msg: "Successfully registered. Error in sending verification email",
      });
    } else {
      return res
        .status(201)
        .json({ success: true, msg: "Successfully registered" });
    }
  } catch (error) {
    console.error("Error during user registration:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const loginController = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res
      .status(400)
      .json({ success: false, msg: "Invalid username or password" });
  }

  const oldUser = await User.findOne({ email });
  if (!oldUser) {
    return res
      .status(400)
      .json({ success: false, msg: "Invalid username or password" });
  }

  const isPasswordCorrect = await bcrypt.compare(password, oldUser.password);
  if (!isPasswordCorrect) {
    return res
      .status(400)
      .json({ success: false, msg: "Invalid username or password" });
  }

  if (!oldUser.verified) {
    return res
      .status(400)
      .json({ success: false, msg: "Please verify your email" });
  }

  const token = tokengenerator({
    email: oldUser.email,
    firstname: oldUser.firstname,
    lastname: oldUser.lastname,
    role: oldUser.role,
    _id: oldUser._id,
    verified: oldUser.verified,
  });
  return res
    .status(200)
    .json({ success: true, token, msg: "You are successfully logged in" });
};

const forgotpasswordController = async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res
      .status(400)
      .json({ success: false, msg: "Please enter a valid email" });
  }

  const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  if (!emailRegex.test(email)) {
    return res
      .status(400)
      .json({ success: false, msg: "Please enter a valid email" });
  }
  const oldUser = await User.findOne({ email });
  if (!oldUser) {
    return res.status(404).json({ success: false, msg: "User not found" });
  }

  const token = tokengenerator({ email: oldUser.email });
  const link = "http://" + req.hostname + ":3000/Resetpassword?token=" + token;

  const sendMail = await sendForgotPasswordEmail(oldUser.email, link);

  if (sendMail) {
    return res
      .status(201)
      .json({ success: true, msg: "Error in sending verification email" });
  } else {
    return res.status(201).json({ success: true, msg: "Email sent" });
  }
};

const resetpasswordController = async (req, res) => {
  const { email, newPassword, confirmNewPassword } = req.body;

  if (!newPassword || !confirmNewPassword || !email) {
    return res
      .status(401)
      .json({ success: false, msg: "Please fill in all the fields" });
  }

  const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  if (!emailRegex.test(email)) {
    return res
      .status(400)
      .json({ success: false, msg: "Please enter a valid email" });
  }

  const oldUser = await User.findOne({ email });

  if (!oldUser) {
    return res.status(400).json({ success: false, msg: "User not found" });
  }

  if (
    newPassword.length < 8 &&
    ![A - Z].test(newPassword) &&
    ![a - z].test(newPassword) &&
    ![0 - 9].test(newPassword) &&
    !/[!@#$%^&*()_\-+=\[\]{};':"\\|,.<>\/?]/.test(newPassword)
  ) {
    return res.status(400).json({
      success: false,
      msg: "Please enter a valid password with at least 8 characters, one uppercase letter, one lowercase letter, one number and one special character",
    });
  }

  if (newPassword !== confirmNewPassword) {
    return res
      .status(400)
      .json({ success: false, msg: "Passwords do not match" });
  }

  const salt = await bcrypt.genSalt(12);
  const hashedPassword = await bcrypt.hash(newPassword, salt);

  const updatedData = await User.findOneAndUpdate(
    { email },
    {
      $set: {
        password: hashedPassword,
      },
    }
  );

  if (updatedData) {
    return res
      .status(200)
      .json({ success: true, msg: "Password updated successfully" });
  } else {
    return res
      .status(500)
      .json({ success: false, msg: "Something went wrong" });
  }
};

const getuserdetails = async (req, res) => {
  try {
    const details = await User.find({});
    const olddetails = await User.findOne({ details });
    return res.status(200).json({ success: true, data: details });
  } catch (error) {
    console.error("Error during user registration:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

export {
  registerController,
  loginController,
  forgotpasswordController,
  resetpasswordController,
  getuserdetails,
};

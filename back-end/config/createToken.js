import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

const generateToken = (data) => {
  return jwt.sign(data,process.env.JWT_SECRET, { expiresIn: "3min" });
};

export default generateToken;

import express from "express";
import verifyEmailController from "../controllers/emailController.js";

const router = express.Router();

// verify email
router.get("/verify", verifyEmailController);

export default router;

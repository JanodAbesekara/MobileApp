import express from "express";
import { createVideo } from "../controllers/video.js";

const router = express.Router();

// Endpoint for creating a video
router.post("/videos", createVideo);

export default router;

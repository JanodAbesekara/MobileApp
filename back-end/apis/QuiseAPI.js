
import express from "express";
import {
  createQuizController,
  getQuizController,
  deleteQuise,
} from "../controllers/QuiseController.js";
import { createAssignmentController } from "../controllers/AssignmentController.js";
import {
  addlecturematerial,
  getlecturematerial,
  deletelecturematerial
} from "../controllers/Lecturematerialcontroller.js";


const router = express.Router();
// quises Api
router.post("/createQuise", createQuizController);
router.get("/getQuise", getQuizController);
router.post("/deleteQuise", deleteQuise);



// lecturematerial Api
router.post("/lecturematerialadd", addlecturematerial);
router.post("/getlecturematerial", getlecturematerial);
router.post("/deletelecturematerial", deletelecturematerial);


export default router;

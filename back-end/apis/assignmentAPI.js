import express from 'express';
import { createAssignmentController ,getAssignmentController,gradeController } from '../controllers/AssignmentController.js';


const router = express.Router();

router.post("/createAssignment", createAssignmentController); //create assignment and upload to the database
router.get("/getAssignment", getAssignmentController);  //fetch created assignment in students profile
router.post("/grade", gradeController); //assignment marks storing to the database for calcculate grades



export default router;
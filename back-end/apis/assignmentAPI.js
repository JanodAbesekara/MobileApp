import express from 'express';
import { createAssignmentController ,getAssignmentController,gradeController,deleteAssignmentController } from '../controllers/AssignmentController.js';


const router = express.Router();

router.post("/createAssignment", createAssignmentController); //create assignment and upload to the database
router.get("/getAssignment", getAssignmentController);  //fetch created assignment in students profile
router.post("/grade", gradeController); //assignment marks storing to the database for calcculate grades

router.delete("/delete/:id", deleteAssignmentController) //when user click the delete button this will delete the created assignment

export default router;
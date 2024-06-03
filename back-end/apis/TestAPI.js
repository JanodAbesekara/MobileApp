import express from "express";

import {quisecontroller,getlecturematerial,getAssignment} from "../controllers/Testcontroller.js";



const router = express.Router();

// Student side Quise
router.get("/quiseadd", quisecontroller);

// Student side Lecture Material
router.get("/getlecturematerial", getlecturematerial);

// Student side Assignment
router.get("/getAssignment", getAssignment);


export default router;

import express from "express";
import {quisecontroller,getlecturematerial,getNotifacition} from "../controllers/Testcontroller.js";

const router = express.Router();

// Student side Quise
router.post("/quiseadd", quisecontroller);

// Student side Lecture Material
router.post("/getlecturematerial", getlecturematerial);






export default router;
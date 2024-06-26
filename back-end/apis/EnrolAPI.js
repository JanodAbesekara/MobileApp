import express from "express";
const router = express.Router();
import {
  Enrolementcontroller,
  StudentEnrollment,
  getSubjects,
  getstudentregistedteachers,
  logoutfromclass,
} from "../controllers/Enrolementcontroller.js";

router.get("/enrolement", Enrolementcontroller);
router.post("/studentEnrollment", StudentEnrollment);
router.get("/getSubject", getSubjects);
router.get("/getteacher", getstudentregistedteachers);
router.post("/logoutfromclass", logoutfromclass);

export default router;

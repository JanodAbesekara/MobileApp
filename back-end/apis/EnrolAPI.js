import express from "express";
const router = express.Router();
import {
  Enrolementcontroller,
  StudentEnrollment,
  getSubjects,
  getstudentregistedteachers,
  logoutfromclass,
  getEnrollmentDetails
} from "../controllers/Enrolementcontroller.js";

router.get("/enrolement", Enrolementcontroller);
router.post("/studentEnrollment", StudentEnrollment);
router.get("/getSubject", getSubjects);
router.get("/getteacher", getstudentregistedteachers);
router.post("/logoutfromclass", logoutfromclass);

router.get("/getEnrolledDetails/:teacherEmail/:subject/:medium",getEnrollmentDetails)

export default router;

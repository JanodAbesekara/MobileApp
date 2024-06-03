import express from "express";
const router = express.Router();

import {
  userProfileController,
  userDetailsController,
  userOtherDetailsController,
  paymentDetailsController,
  fetchPaymentDetailsController,
  studentParentDetailsController,
  updateUserProfileController,
  deleteEntireCard,
  studentProfile,
  parentDetails,
  Admindeisplay,
  Admindelete,
  AdminCrete,

} from "../controllers/userProfileController.js";

import {
  studentattendenceController,
  teacherattendenceController,
  studentattendencegetController,
  techerlecturecountget,
  editlecturecount,
  displayteacherattendence,
  getstudentattendence,
} from "../controllers/studentAttendencecontrollers.js";

import  {getRegisteredSubject,getSubject}  from "../controllers/SubjectRegistercontroller.js";

router.post("/userProfile", userProfileController);
router.post("/studentattendence", studentattendenceController);
router.get("/studenceattendenceget", studentattendencegetController);
router.post("/techeralectureget", techerlecturecountget);
router.post("/teacherlecture", teacherattendenceController);
router.post("/editlecturecount", editlecturecount);
router.post("/teacherattendence", displayteacherattendence);
router.get("/getstudentattendence", getstudentattendence);

//save payment details of teacher
router.post("/payment", paymentDetailsController);
router.get("/payment/:userID", fetchPaymentDetailsController);

//get user name and details that are entered when the registration
router.get("/userProfile/:userID", userDetailsController);
//get teacher's data added from userprofile

router.get("/dashboard/:userID", userOtherDetailsController);

// subject get from registered

router.get("/getsubjectreg", getRegisteredSubject);

// admin display 
router.get("/admindisplay", Admindeisplay);
router.post("/admindelete", Admindelete);
router.post("/admincreate", AdminCrete);


//students guardian details

router.post("/guardian", studentParentDetailsController);

//update users details based on classes
router.put("/update/:subID", updateUserProfileController);
// delete entire subject card
router.delete("/delete/:deleted", deleteEntireCard);

//get specific student
router.get("/name/:studentEmail",studentProfile);

//get specific parent relevant to student
router.get("/parent/:studentEmail",parentDetails);

//get specific teachers subjects
router.get("/getsubjects/:teacherEmail",getSubject);

export default router;

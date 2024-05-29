import express from "express";
import {
  registerController,
  loginController,
  forgotpasswordController,
  resetpasswordController,
  getuserdetails,
} from "../controllers/authController.js";
import verifyTokenController from "../controllers/verifyTokenController.js";
import {
  fileuplodController,
  fileurlcontroller,
  checkold_user,
  deletefilecontroller,
} from "../controllers/filehandle.js";
import {
  postupdateController,
  postDetailsControl,
  deletepostcontroller,
} from "../controllers/PostControler.js";

import { studentdetails, removeStudent ,teacherdetails,removeteacher} from "../controllers/Studentcontroller.js";
import  {feedbackget ,feedbackput ,deletFeedback}  from "../controllers/feedbackcontroler.js";
const router = express.Router();

// register user api
router.post("/register", registerController);

// login api
router.post("/login", loginController);

// forgotpassword api
router.post("/forgotpassword", forgotpasswordController);

// verify token
router.get("/verifyToken", verifyTokenController);

// Reset password
router.post("/resetpassword", resetpasswordController);

// file adding remving apis
router.post("/fileupload", fileuplodController);

router.get("/fileurlsend", fileurlcontroller);

router.post("/deletefile", deletefilecontroller);

// post apis

router.post("/postupdate", postupdateController);

router.get("/postdetails", postDetailsControl);

router.post("/deletepost", deletepostcontroller);

// student managemnet apis

router.get("/studentget", studentdetails);

router.post("/studentpost",  removeStudent);
// teachers mamangement apis

router.get("/teachermangement", teacherdetails);

router.post("/teacherremove", removeteacher);

router.get("/checkold_user", checkold_user);
// feedback apis 

router.post("/feedbackadd" , feedbackget);

router.get("/feedbackget", feedbackput);

router.post("/deletefeedback", deletFeedback);

// Qr code
router.get("/getuserdetails", getuserdetails);

export default router;

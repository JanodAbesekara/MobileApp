import usermodel from "../models/usermodel.js";
import profile from "../models/userProfileModel.js";
import Announcement from "../models/Announcementmodel.js";
import Getfeedbacksmodel from "../models/Getfeedbacksmodel.js";
import Lecturematerial from "../models/Lecturematerial.js";
import Assignment from "../models/Assignmentmodel.js";
import postmodels from "../models/Postmodels.js";
import quisemodel from "../models/Quizzesmodels.js";
import teacherlecturecount from "../models/TeacherLecturecountmodel.js";
import Enrollment from "../models/Enrollmentmdels.js";
import studentprofile from "../models/studentProfileModel.js";

const studentdetails = async (req, res) => {
  try {
    const students = await usermodel.find({ role: "Student" });

    return res.status(200).json({ success: true, data: students });
  } catch (error) {
    console.error("Error during student details:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const removeStudent = async (req, res) => {
  try {
    const data = req.body;
    const email = data.email;
    await usermodel.deleteOne({ email });
    await Enrollment.deleteOne({userEmail:email});
    await studentprofile.deleteOne({email});
    return res
      .status(200)
      .json({ success: true, msg: "Student deleted successfully" });
  } catch (error) {
    console.error("Error during student deletion:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const teacherdetails = async (req, res) => {
  try {
    const teachers = await usermodel.find({ role: "Lecturer" });

    return res.status(200).json({ success: true, data: teachers });
  } catch (error) {
    console.error("Error during teacher details:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const removeteacher = async (req, res) => {
  try {
    const data = req.body;
    const email = data.email;
    await usermodel.deleteOne({ email });
    await teacherlecturecount.deleteOne({ teacheremail: email });
    await quisemodel.deleteOne({ TeacherEmail : email });
    await postmodels.deleteOne({ email });
    await Assignment.deleteOne({TeacherEmail:email});
    await Lecturematerial.deleteOne({TeacherEmail:email});
    await Getfeedbacksmodel.deleteOne({ teacheremail:email});
    await Announcement.deleteOne({postedemail:email});
    await profile.deleteOne({email});
    return res
      .status(200)
      .json({ success: true, msg: "Teacher deleted successfully" });
  } catch (error) {
    console.error("Error during teacher deletion:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

export { studentdetails, removeStudent, teacherdetails, removeteacher };

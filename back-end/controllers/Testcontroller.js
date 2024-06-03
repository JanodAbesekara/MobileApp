import Enrollment from "../models/Enrollmentmdels.js";
import Quize from "../models/Quizzesmodels.js";
import lecturematerial from "../models/Lecturematerial.js";
import Announcement from "../models/Announcementmodel.js";

const quisecontroller = async (req, res) => {
  const { email } = req.body;

  try {
    // Find enrollments for the given user email
    const enrollments = await Enrollment.find({ userEmail: email });

    // Extract the subjects, mediums, and teacherEmails from the enrollments
    const subjects = enrollments.map((enroll) => enroll.Ensubject);
    const mediums = enrollments.map((enroll) => enroll.Enmedium);
    const teacherEmails = enrollments.map((enroll) => enroll.teacherEmail);

    // Filter quizzes based on extracted subjects, mediums, and teacherEmails
    const quizes = await Quize.find({
      TeacherSubject: { $in: subjects },
      submedium: { $in: mediums },
      TeacherEmail: { $in: teacherEmails },
    });

    res.status(200).json({ success: true, quizes });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};

const getlecturematerial = async (req, res) => {
  const { teachermail, subject, medium } = req.body;

  try {
    const lecturematerials = await lecturematerial.find({
      TeacherEmail: teachermail,
      Teachersubject: subject,
      Tmedium: medium,
    });
    res.status(200).json({ success: true, data: lecturematerials });
  } catch (error) {
    res.status(500).json({ success: false, msg: "Server error" });
  }
};

const getNotifacition = async (req, res) => {
  try {
    const { email } = req.body;

    // Fetch enrollments for the user
    const enrollments = await Enrollment.find({ userEmail: email });

    const announceme = await Announcement.find({ jobrole: "Admin" });

    // Extract job roles from enrollments
    const uniqueJobRoles = [
      ...new Set(enrollments.map((enrollment) => enrollment.jobRole)),
    ];

    if (uniqueJobRoles.length > 1) {
      return res
        .status(400)
        .json({ success: false, msg: "Inconsistent job roles in enrollments" });
    }

    // Extract subjects, medium, and teacher emails from enrollments
    const subjects = enrollments.map((enrollment) => enrollment.Ensubject);
    const medium = enrollments.map((enrollment) => enrollment.Enmedium);
    const teacherEmails = enrollments.map(
      (enrollment) => enrollment.teacherEmail
    );

    let announcements;

    // Fetch announcements based on job role
    if (uniqueJobRoles[0] === "Admin") {
      // Fetch all announcements if the user is an Admin
      announcements = await Announcement.find({});
    } else {
      // Fetch announcements for the enrolled subjects
      announcements = await Announcement.find({
        TeacheSubject: { $in: subjects },
        mediua: { $in: medium },
        postedemail: { $in: teacherEmails },
      });
    }

    // Return the announcements
    return res.status(200).json({ success: true, announcements, announceme });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};



const getNotificationT = async (req, res) => {
  try {

    const announcements = await Announcement.find({ jobrole: "Admin" });
     res.status(200).json({ success: true, announcements });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }

};
export { quisecontroller, getlecturematerial, getNotifacition ,getNotificationT  };

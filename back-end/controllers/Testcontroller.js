import Enrollment from "../models/Enrollmentmdels.js";
import Quize from "../models/Quizzesmodels.js";
import lecturematerial from "../models/Lecturematerial.js";
import Announcement from "../models/Announcementmodel.js";
import Assignment from "../models/Assignmentmodel.js";




 const getAssignment = async (req, res) => {
  
  const {email} = req.query;


  try {
    // Find enrollments for the given user email
    const enrollments = await Enrollment.find({ userEmail: email });

    // Extract the subjects, mediums, and teacherEmails from the enrollments
    const enrollmentSets = enrollments.map((enroll) => ({
      subject: enroll.Ensubject,
      medium: enroll.Enmedium,
      email: enroll.teacherEmail,
    }));

    const assignments = await Assignment.find({
      $or: enrollmentSets.map((enroll) => ({
        TeacherSubject: enroll.subject,
        submedium: enroll.medium,
        TeacherEmail: enroll.email,
      })),
    });

    res.status(200).json({ success: true, assignments });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};

const quisecontroller = async (req, res) => {
  const { email } = req.query;

  try {
    // Find enrollments for the given user email
    const enronments = await Enrollment.find({ userEmail: email });

    // Extract the subjects, mediums, and teacherEmails from the enrollments

    const enrollmentSets = enronments.map((enroll) => ({
      subject: enroll.Ensubject,
      medium: enroll.Enmedium,
      email: enroll.teacherEmail,
    }));

    // Filter quizzes based on extracted subjects, mediums, and teacherEmails
    const quizzes = await Quize.find({
      $or: enrollmentSets.map((enroll) => ({
        TeacherSubject: enroll.subject,
        submedium: enroll.medium,
        TeacherEmail: enroll.email,
      })),
    });

    res.status(200).json({ success: true, quizzes });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};

const getlecturematerial = async (req, res) => {
  const { teachermail, subject, medium } = req.query;

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
    const { email } = req.query;

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
    const enrollmentSets = enrollments.map((enroll) => ({
      subject: enroll.Ensubject,
      medium: enroll.Enmedium,
      email: enroll.teacherEmail,
    }));

    let announcements;

    // Fetch announcements based on job role
    if (uniqueJobRoles[0] === "Admin") {
      // Fetch all announcements if the user is an Admin
      announcements = await Announcement.find({});
    } else {
      // Fetch announcements for the enrolled subjects
      announcements = await Announcement.find({
        $or: enrollmentSets.map((enroll) => ({
          TeacheSubject: enroll.subject,
          mediua: enroll.medium,
          postedemail: enroll.email,
        })),
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

export {
  quisecontroller,
  getlecturematerial,
  getNotifacition,
  getNotificationT,
  getAssignment,
};

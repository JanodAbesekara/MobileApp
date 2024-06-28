import attendennceSchema from "../models/studentAttendesmodel.js";
import teacherlecture from "../models/TeacherLecturecountmodel.js";

const studentattendenceController = async (req, res) => {
  const { studentnemail, studentname, subject, teachetmail, medium } = req.body;

  // Validate required fields
  if (!studentnemail || !studentname || !subject || !teachetmail || !medium) {
    return res
      .status(400)
      .json({ success: false, msg: "Please fill all the fields" });
  }

  try {
    // Efficiently Find Existing Attendance (if any)
    const existingAttendance = await attendennceSchema.findOne({
      studentnemail,
      subject,
      medium,
      // Filter by subject for subject-specific attendance
    });

    let newCountAttendence;

    if (existingAttendance) {
      // Increment countAttendence if record exists for the student and subject
      newCountAttendence = existingAttendance.countAttendence + 1;
      existingAttendance.countAttendence = newCountAttendence; // Update existing document

      await existingAttendance.save(); // Save updated countAttendence
    } else {
      // Create new attendance record if no previous entry exists
      newCountAttendence = 1; // Initial count for new record
      const attendance = new attendennceSchema({
        studentnemail,
        studentname,
        subject,
        countAttendence: newCountAttendence,
        teachetmail,
        medium,
      });
      await attendance.save();
    }

    res
      .status(201)
      .json({ success: true, msg: "Attendance marked successfully" });
  } catch (error) {
    console.error(error); // Log the error for debugging
    res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};

const studentattendencegetController = async (req, res) => {
  const { studentemail, subject, medium, teacheremail } = req.body;

  try {
    const attendances = await attendennceSchema.find({ studentnemail:studentemail ,subject: subject, medium: medium, teachetmail: teacheremail});

    if (!attendances.length) {
      res.status(404).json({ success: false, msg: "No attendence found" });
    } else {
      res.status(200).json({ success: true, data: attendances });
    }
  } catch (error) {
    res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};

const teacherattendenceController = async (req, res) => {
  const { teacheremail, leccount, subject, media } = req.body;
  if (!teacheremail || !leccount || !subject || !media) {
    return res
      .status(400)
      .json({ success: false, msg: "Please fill all the fields" });
  }
  try {
    const lecture = new teacherlecture({
      teacheremail,
      leccount,
      media,
      subject,
    });

    await lecture.save();

    res.status(201).json({ success: true, msg: "Lecture marked successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};

const techerlecturecountget = async (req, res) => {
  const { teacheremail, subject, medium } = req.body;
  try {
    const leccount = await teacherlecture.find({
      teacheremail: teacheremail,
      subject: subject,
      media: medium,
    });
    if (!leccount.length) {
      res.status(404).json({ success: false, msg: "No lecture count found" });
    } else {
      res.status(200).json({ success: true, data: leccount });
    }
  } catch (error) {
    res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};

const displayteacherattendence = async (req, res) => {
  const { teacheremail, subject, media } = req.body;
  try {
    const teacherattendence = await teacherlecture.find({
      teacheremail,
      subject,
      media,
    });
    const oldteacherattendence = await teacherlecture.findOne({
      teacherattendence,
    });

    if (oldteacherattendence) {
      return res
        .status(403)
        .json({ success: false, msg: "Details already exists" });
    } else {
      return res.status(200).json({ success: true, data: teacherattendence });
    }
  } catch (error) {
    res.status(500).json({ success: false, msg: "internal Server Error" });
  }
};

const editlecturecount = async (req, res) => {
  try {
    const { teacheremail, leccount, media, subject } = req.body;
    teacherlecture
      .updateOne(
        { teacheremail: teacheremail, subject: subject, media: media },
        { $set: { leccount: leccount } }
      )
      .then((result) => {
        res
          .status(200)
          .json({ success: true, msg: "Lecture Time and Count updated " });
      });
  } catch (error) {
    res.status(500).json({ success: false, msg: "internal Server Error" });
  }
};

const getstudentattendence = async (req, res) => {
  try {
    // Retrieve data from the schemas
    const students = await attendennceSchema.find();
    const lectures = await teacherlecture.find();

    // Create Maps for efficient lookups
    const studentMap = new Map();
    const lectureMap = new Map();

    // Build Maps with unique teacher-subject-medium combinations
    for (const student of students) {
      const key = `${student.teachetmail}-${student.subject}-${student.medium}`;
      if (key) {
        if (!studentMap.has(key)) {
          studentMap.set(key, []);
        }
        studentMap.get(key).push(student);
      }
    }

    for (const lecture of lectures) {
      const key = `${lecture.teacheremail}-${lecture.subject}-${lecture.media}`;
      if (key) {
        if (!lectureMap.has(key)) {
          lectureMap.set(key, []);
        }
        lectureMap.get(key).push(lecture);
      }
    }

    // Find common keys between studentMap and lectureMap
    const commonKeys = [...studentMap.keys()].filter((key) =>
      lectureMap.has(key)
    );

    // Combine data efficiently
    const combinedData = [];
    for (const key of commonKeys) {
      const studentData = studentMap.get(key);
      const lectureData = lectureMap.get(key);

      studentData.forEach((student) => {
        combinedData.push({
          email: student.studentemail,
          profile: lectureData,
          posts: student,
        });
      });
    }

    // Return the combined data
    return res.status(200).json({ success: true, data: combinedData });
  } catch (error) {
    console.error("Error retrieving data:", error);
    return res
      .status(500)
      .json({ success: false, message: "Internal Server Error" });
  }
};

export {
  studentattendenceController,
  teacherattendenceController,
  studentattendencegetController,
  techerlecturecountget,
  displayteacherattendence,
  editlecturecount,
  getstudentattendence,
};

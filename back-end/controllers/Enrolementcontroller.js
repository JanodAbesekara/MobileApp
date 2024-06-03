import profileSchema from "../models/userProfileModel.js";
import userSchema from "../models/usermodel.js";
import EnrollmentSchema from "../models/Enrollmentmdels.js";

const Enrolementcontroller = async (req, res) => {
  try {
    const enrolement = await profileSchema.find();
    const userdata = await userSchema.find();

    // Extract unique email addresses from both datasets
    const enrolementEmails = new Set(enrolement.map((item) => item.email));
    const userDataEmails = new Set(userdata.map((item) => item.email));

    // Find common email addresses across all datasets
    const commonEmails = [...enrolementEmails].filter((email) =>
      userDataEmails.has(email)
    );

    // Combine data where email is common
    const combinedData = [];

    for (const email of commonEmails) {
      const userPosts = userdata.filter((item) => item.email === email);
      const userProfile = enrolement.filter((item) => item.email === email);

      if (userProfile.length > 0 && userPosts.length > 0) {
        const combinedPosts = [];
        userPosts.forEach((post) => {
          combinedPosts.push({
            email: post.email,
            profile: userProfile,
            posts: post,
          });
        });
        combinedData.push(...combinedPosts);
      }
    }

    return res.status(200).json({ success: true, data: combinedData });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const StudentEnrollment = async (req, res) => {
  const { userEmail, teacherEmail, Ensubject, Enmedium } = req.body;

  if (userEmail == null) {
    return res
      .status(400)
      .json({ success: false, msg: "Please Register to the Site" });
  }

  if (!userEmail || !teacherEmail || !Ensubject || !Enmedium) {
    return res
      .status(400)
      .json({ success: false, msg: "Please fill in all the fields" });
  }

  try {
    const oldenrollment = await EnrollmentSchema.findOne({
      userEmail,
      teacherEmail,
      Ensubject,
      Enmedium,
    });

    if (oldenrollment) {
      return res.status(400).json({
        success: false,
        msg: "You are already enrolled in this course",
      });
    }

    const registeduser = await userSchema.findOne({ email: userEmail });

    if (!registeduser) {
      return res
        .status(400)
        .json({ success: false, msg: "You are not Registed please registed " });
    }

    const registedteacher = await userSchema.findOne({
      role: { $in: ["Admin", "Lecturer"] },
      email: userEmail,
    });
    if (registedteacher) {
      return res
        .status(400)
        .json({ success: false, msg: "Only Student can registered !" });
    }

    const newEnrollment = new EnrollmentSchema({
      userEmail,
      teacherEmail,
      Ensubject,
      Enmedium,
    });

    await newEnrollment.save();

    return res
      .status(200)
      .json({ success: true, msg: "Enrollment successful" });
  } catch (error) {
    console.error("Error during enrollment:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const getSubjects = async (req, res) => {
  try {
    const subjects = await EnrollmentSchema.find();
    return res.status(200).json({ success: true, data: subjects });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const getstudentregistedteachers = async (req, res) => {
  try {
    const enrolteacher = await EnrollmentSchema.find();

    return res.status(200).json({ success: true, data: enrolteacher });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const logoutfromclass = async (req, res) => {
  try {
    const data = req.body;

    const email = data.teacherEmail;
    const subject = data.Ensubject;
    const medium = data.Enmedium;
    const useremail = data.userEmail;

    await EnrollmentSchema.deleteOne({
      userEmail: useremail,
      teacherEmail: email,
      Ensubject: subject,
      Enmedium: medium,
    });
    return res.status(200).json({
      success: true,
      msg: `You want to logout from this ${subject} ${medium} medium class`,
    });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const getEnrollmentDetails = async (req,res) => {
   const { teacherEmail,subject, medium} = req.params;
   try{
    const details =  await EnrollmentSchema.find({
      teacherEmail : teacherEmail,
      Ensubject : subject,
      Enmedium : medium
    });
    return res
              .status(200).json({success:true , data: details});
   } catch(error) {
    return res
              .status(500).json({success:false ,  msg:"Data getting is failed"})
   }
}

export {
  Enrolementcontroller,
  StudentEnrollment,
  getSubjects,
  getstudentregistedteachers,
  logoutfromclass,
  getEnrollmentDetails
};

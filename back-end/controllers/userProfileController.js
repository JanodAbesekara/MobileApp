import profilemodel from "../models/userProfileModel.js";
import usermodel from "../models/usermodel.js";
import paymentmodel from "../models/paymentModel.js";
import studentProfileModel from "../models/studentProfileModel.js";


const userProfileController = async (req, res) => {
  const {
    medium,
    scheme,
    subject,
    degree,
    experience,
    aboutme,
    email,
    id,
    url,
  } = req.body;

  const olduser = await profilemodel.findOne({ email, subject, medium });

  if (olduser) {
    return res
      .status(403)
      .json({ success: false, msg: "Already filled the Fields " });
  }

  try {
    const newprofile = new profilemodel({
      medium,
      scheme,
      subject,
      degree,
      experience,
      aboutme,
      email,
      id,
      url,
    });

    await newprofile.save();
    return res
      .status(200)
      .json({ success: true, msg: "Profile details uploaded successfully" });
  } catch (error) {
    console.error("An error has occured !", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Sever Error" });
  }
};

const userDetailsController = async (req, res) => {
  try {
    const fetchID = req.params.userID;
    const user = await usermodel.findById(fetchID);
    return res.json(user);
  } catch (error) {
    return res.json("An error occurred");
  }
};

const userOtherDetailsController = async (req, res) => {
  try {
    const id = req.params.userID;
    const details = await profilemodel.findOne({ id });
    if (details) {
      return res.json(details);
    }
  } catch (error) {
    return res.json("Error getting user details");
  }
};

const paymentDetailsController = async (req, res) => {
  const { bank, accountNo, id } = req.body;
  if (!bank || !accountNo) {
    return res.json({ success: false, msg: "Missing something" });
  }
  try {
    const paymentDetails = new paymentmodel({
      id,
      bank,
      accountNo,
    });
    await paymentDetails.save();
    return res.json({ success: true, msg: "Saved successfully" });
  } catch (error) {
    return res.json({ success: false, msg: "Internal Sever Error" });
  }
};

const fetchPaymentDetailsController = async (req, res) => {
  try {
    const id = req.params.userID;
    const details = await paymentmodel.findOne({ id });
    if (details) {
      return res.json(details);
    }
  } catch (error) {
    return res.json("Error getting user details");
  }
};

const studentParentDetailsController = async (req, res) => {
  const { name, email, mobileNo, uEmail, id } = req.body;

  if (!name || !email || !mobileNo) {
    return res
      .status(400)
      .json({ success: false, msg: "Please fill all the fields" });
  }

  try {
    const parentDetails = new studentProfileModel({
      name,
      email,
      mobileNo,
      uEmail,
      id,
    });
    await parentDetails.save();
    return res
      .status(200)
      .json({ success: true, msg: "Guardian details uploaded successfully" });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Sever Error" });
  }
};

const updateUserProfileController = async (req, res) => {
  const id = req.params.subID; // Get the ID of the profile to update
  const { degree, experience, aboutme } = req.body; // Extract updated data from request body

  try {
    // Find the profile by ID
    const profile = await profilemodel.findByIdAndUpdate(id, {
      degree,
      experience,
      aboutme,
    });

    // If profile doesn't exist, return an error
    if (!profile) {
      return res.status(404).json({ success: false, msg: "Profile not found" });
    }

    // Return success message
    return res
      .status(200)
      .json({ success: true, msg: "Profile updated successfully" });
  } catch (error) {
    console.error("An error occurred while updating profile:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const deleteEntireCard = async (req, res) => {
  const id = req.params.deleted;
  try {
    await profilemodel.findByIdAndDelete(id);
    return res.status(200).json({ success: true, msg: "Success" });
  } catch (error) {
    return res.status(500).json({ success: false, msg: "error" });
  }
};

const Admindeisplay = async (req, res) => {
  try {
    const users = await usermodel.find({ role: "Admin" });
    return res.status(200).json({ success: true, data: users });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};


const studentProfile = async (req,res) => {
  const studentEmail = req.params.studentEmail;
  try {
      const studentData =  await usermodel.findOne({
        email: studentEmail,
      });
      if (!studentData) {
        return res.status(404).json({ success: false, msg: "Student not found" });
      }
      return res.status(200).json({ success: true, data: studentData });
  } catch (error) {
    return res.status(500).json({success:false , msg: "An unexpected error occured"});
  }
}

const parentDetails = async (req,res) => {
  const studentEmail = req.params.studentEmail;
  try {
      const parentData = await studentProfileModel.findOne({
        uEmail:studentEmail,
      });
      if (!parentData) {
        return res.status(404).json({ success: false, msg: "Parent details not found" });
      }
      return res.status(200).json({ success: true, data: parentData });
  } catch (error) {
    return res.status(500).json({success:false , msg:"An unexpected error occured"});
  }
}

const Admindelete = async (req, res) => {
  const { id } = req.body;
  try {
    await usermodel.findByIdAndDelete(id);
    return res.status(200).json({ success: true, msg: "SuccessFully Delete" });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const AdminCrete = async (req, res) => {
  const { email } = req.body;
  
  try {
    const existingUser = await usermodel.findOne({ email: email });
    
    if (existingUser) {
      existingUser.role = "Admin";
      await existingUser.save();
      return res.status(200).json({ success: true, msg: "Role updated to Admin" });
    } else {
      const newAdmin = new usermodel({
        email: email,
        role: "Admin",
      });
      await newAdmin.save();
      return res.status(200).json({ success: true, msg: "Successfully created Admin" });
    }
  } catch (error) {
    return res.status(500).json({ success: false, msg: "Internal Server Error" });
  }
};


export {
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
};

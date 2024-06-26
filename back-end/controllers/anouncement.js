import Announcement from "../models/Announcementmodel.js";
import EnrollmentSchema from "../models/Enrollmentmdels.js";


const postanouncement = async (req, res) => {
  const {
    postedemail,
    TeacheSubject,
    Announcementmessage,
    titleofAnn,
    date,
    time,
    jobrole,
    mediua,
  } = req.body;
  try {
    if (
      !postedemail ||
      !jobrole ||
      !Announcementmessage ||
      !titleofAnn ||
      !date ||
      !time 
     
    ) {
      return res
        .status(400)
        .json({ success: false, message: "All fields are required" });
    } else {
      const newannouncement = new Announcement({
        postedemail,
        TeacheSubject,
        Announcementmessage,
        titleofAnn,
        date,
        time,
        jobrole,
        mediua,
      });
      await newannouncement.save();
      return res
        .status(200)
        .json({ success: true, message: "Announcement posted successfully" });
    }
  } catch (err) {
    console.log(err);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

const getAnnuncements = async (req, res) => {
  try {
    const announcements = await Announcement.find();
    return res.status(200).json({ success: true, announcements });
  } catch (err) {
    console.log(err);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

const deleteAnnouncement = async (req, res) => {
  try {
    const { id } = req.body;
    await Announcement.deleteOne({ id });
    return res
      .status(200)
      .json({ success: true, message: "Announcement deleted successfully" });
  } catch (err) {
    console.log(err);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

export { postanouncement, getAnnuncements, deleteAnnouncement };

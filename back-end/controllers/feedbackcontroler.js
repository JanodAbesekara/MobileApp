import Getfeedbacks from "../models/Getfeedbacksmodel.js";

const feedbackget = async (req, res) => {
  const {
    feedtext,
    value,
    studentemail,
    teacheremail,
    feedSubject,
    feedmedium,
  } = req.body;

  if (
    !feedtext ||
    !value ||
    !studentemail ||
    !teacheremail ||
    !feedSubject ||
    !feedmedium
  ) {
    return res
      .status(400)
      .json({ success: false, msg: "Please fill in all the fields" });
  }

  try {
    const newfeedback = new Getfeedbacks({
      feedtext,
      value,
      studentemail,
      teacheremail,
      feedSubject,
      feedmedium,
    });

    const oldfeedback = await Getfeedbacks.findOne({
      studentemail,
      teacheremail,
      feedSubject,
      feedmedium,
    });
    if (oldfeedback) {
      return res
        .status(400)
        .json({ success: false, msg: "Feedback already exists" });
    }

    await newfeedback.save();
    return res
      .status(200)
      .json({ success: true, msg: "Feedback uploaded successfully" });
  } catch (error) {
    console.error("Error during feedback upload:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const feedbackput = async (req, res) => {
  try {
    const feedbacks = await Getfeedbacks.find();
    return res.status(200).json({ success: true, data: feedbacks });
  } catch (error) {
    console.error("Error during feedback fetch:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

const deletFeedback = async (req, res) => {
  const { _id } = req.body;

  if (!_id) {
    return res
      .status(400)
      .json({ success: false, msg: "Please provide an id" });
  }

  try {
    await Getfeedbacks.findByIdAndDelete(_id);
    return res
      .status(200)
      .json({ success: true, msg: "Feedback deleted successfully" });
  } catch (error) {
    console.error("Error during feedback delete:", error);
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

export { feedbackget, feedbackput, deletFeedback };

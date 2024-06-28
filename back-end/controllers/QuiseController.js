import Quiz from "../models/Quizzesmodels.js";

const createQuizController = async (req, res) => {
  const {
    TeacherEmail,
    TeacherSubject,
    QuizeNumber,
    question,
    TimeRanges,
    submedium,
  } = req.body;

  try {
    if (
      !TeacherEmail ||
      !TeacherSubject ||
      !QuizeNumber ||
      !question ||
      !TimeRanges ||
      !submedium
    ) {
      return res.status(400).json({ message: "All fields are required" });
    }
    if (question.length === 0) {
      return res
        .status(400)
        .json({ message: "At least one question is required" });
    }
    if (question.length > 30 && question.length < 1) {
      return res.status(400).json({
        message: "Maximum 30 questions are allowed and Minimun length 1",
      });
    }

    const oldQuiz = await Quiz.findOne({
      QuizeNumber,
      TeacherSubject,
      TeacherEmail,
      submedium,
    });
    if (oldQuiz) {
      return res
        .status(403)
        .json({ success: false, message: "Quiz already exists" });
    }

    const newQuiz = new Quiz({
      TeacherEmail,
      TeacherSubject,
      QuizeNumber,
      question,
      TimeRanges,
      submedium,
    });

    await newQuiz.save();
    return res
      .status(201)
      .json({ message: "Quiz created successfully", quiz: newQuiz });
  } catch (error) {
    res.status(409).json({ message: error.message });
  }
};

const getQuizController = async (req, res) => {
  try {
    const quiz = await Quiz.find();
    res.status(200).json(quiz);
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};

const deleteQuise = async (req, res) => {
  const { _id } = req.body;

  if (!_id) {
    return res.status(400).json({ success: false, msg: "ID Not Found" });
  }
  try {
    await Quiz.findByIdAndDelete(_id);
    return res
      .status(200)
      .json({ success: true, msg: "Quiz Deleted Successfully" });
  } catch (error) {
    return res
      .status(500)
      .json({ success: false, msg: "Internal Server Error" });
  }
};

export { createQuizController, getQuizController, deleteQuise };

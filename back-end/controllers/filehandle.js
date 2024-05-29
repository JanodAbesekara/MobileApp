import files from "../models/Filemodels.js";
import User from "../models/usermodel.js";

const fileuplodController = async (req, res) => {
  const {
    PDFurl,
    pdfS,
    discriP,
    videoUrl,
    videos,
    discriV,
    audioUrl,
    audios,
    discriA,
    pdfmedia,
    videoMedia,
    audioMedia,
  } = req.body;

  if (!PDFurl && !videoUrl && !audioUrl) {
    return res
      .status(400)
      .json({ Success: false, msg: "At least one file is required" });
  }

  try {
    if (PDFurl) {
      const existingPDF = await files.findOne({ discriP: discriP });
      if (existingPDF) {
        return res
          .status(403)
          .json({ Success: false, msg: "PDF already exists" });
      }

      const newPDF = new files({ PDFurl, pdfS, discriP, pdfmedia });

      await newPDF.save();
      return res
        .status(200)
        .json({ Success: true, msg: "PDF uploaded successfully" });
    } else if (videoUrl) {
      const existingVideo = await files.findOne({ discriV: discriV });
      if (existingVideo) {
        return res
          .status(403)
          .json({ Success: false, msg: "Video already exists" });
      }

      const newVideo = new files({ videoUrl, videos, discriV, videoMedia });

      await newVideo.save();
      return res
        .status(200)
        .json({ Success: true, msg: "Video uploaded successfully" });
    } else if (audioUrl) {
      const existingAudio = await files.findOne({ discriA: discriA });
      if (existingAudio) {
        return res
          .status(403)
          .json({ Success: false, msg: "Audio already exists" });
      }

      const newAudio = new files({ audioUrl, audios, discriA, audioMedia });

      await newAudio.save();
      return res
        .status(200)
        .json({ Success: true, msg: "Audio uploaded successfully" });
    }
  } catch (err) {
    return res
      .status(500)
      .json({ Success: false, msg: "Internal Server Error" });
  }
};

const fileurlcontroller = async (req, res) => {
  try {
    const filesurl = await files.find({});
    const oldurl = await files.findOne({ filesurl });

    if (oldurl) {
      return res
        .status(403)
        .json({ Success: false, msg: "File already exists" });
    } else {
      return res.status(200).json({ Success: true, data: filesurl });
    }
  } catch (err) {
    console.error("Error saving file:", err);
    res.status(500).json({ Success: false, msg: "Internal Server Error" });
  }
};

const checkold_user = async (req, res) => {
  try {
    const users = await User.find({}, { email: 1 });
    const emails = users.map((user) => user.email);

    return res.status(200).json({ Success: true, data: emails });
  } catch (err) {
    console.error("Error saving file:", err);
    res.status(500).json({ Success: false, msg: "Internal Server Error" });
  }
};

const deletefilecontroller = async (req, res) => {
  const { _id } = req.body;

  try {
    const file = await files.deleteOne({ _id });
    if (!file) {
      return res.status(404).json({ Success: false, msg: "File not found" });
    }
    return res.status(200).json({ Success: true, msg: "File deleted" });
  } catch (err) {
    console.error("Error deleting file:", err);
    res.status(500).json({ Success: false, msg: "Internal Server Error" });
  }
};

export {
  fileuplodController,
  fileurlcontroller,
  checkold_user,
  deletefilecontroller,
};

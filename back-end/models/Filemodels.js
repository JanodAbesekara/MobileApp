import mongoose from "mongoose";
const { Schema } = mongoose;

const fileSchema = new Schema(
  {
    PDFurl: {
      type: String,
    },
    pdfS: {
      type: String,
    },
    discriP: {
      type: String,
    },
    videoUrl: {
      type: String,
    },
    videos: {
      type: String,
    },
    discriV: {
      type: String,
    },
    audioUrl: {
      type: String,
    },
    audios: {
      type: String,
    },
    discriA: {
      type: String,
    },
    pdfmedia: {
      type: String,
    },
    videoMedia: {
      type: String,
    },
    audioMedia: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model("files", fileSchema);

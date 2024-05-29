import mongoose from "mongoose";
const { Schema } = mongoose;

const lecturematerialSchema = new Schema(
  {
    lesson: {
      type: String,
      required: true,
    },
    Teachersubject: {
      type: String,
      required: true,
    },
    Tmedium: {
      type: String,
      required: true,
    },
    TeacherEmail: {
      type: String,
      required: true,
    },
    zoom: {
      type: String,
      required: true,
    },
    PDF: {
      type: String,
      required: true,
    },

    video: {
      type: String,
    },
    otherlink: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);
export default mongoose.model("lecturematerial", lecturematerialSchema);

import mongoose from "mongoose";
const { Schema } = mongoose;

const EnrollmentSchema = new Schema(
  {
    userEmail: {
      type: String,
      required: true,
    },
    teacherEmail: {
      type: String,
      required: true,
    },
    Ensubject: {
      type: String,
      required: true,
    },
    Enmedium: {
      type: String,
      required: true,
    },
  },

  { timestamps: true }
);

const Enrollment = mongoose.model("Enrollment", EnrollmentSchema);
export default Enrollment;

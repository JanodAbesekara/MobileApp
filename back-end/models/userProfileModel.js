import mongoose from "mongoose";

const { Schema } = mongoose;

const profileSchema = new Schema(
  {
    medium: {
      type: String,
      required: true,
    },
    scheme: {
      type: String,
      required: true,
    },
    subject: {
      type: String,
      required: true,
    },
    degree: {
      type: String,
    },
    experience: {
      type: String,
      required: true,
    },
    aboutme: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
    id: {
      type: String,
    },
    url: {
      type: String,
    }
  },
  {
    timestamps: true,
  }
);

export default mongoose.model("profile", profileSchema);

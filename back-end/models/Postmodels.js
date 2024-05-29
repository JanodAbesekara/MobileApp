import mongoode from "mongoose";

const { Schema } = mongoode;

const postuplo = new Schema(
  {
    edulevel: {
      type: String,
      enum: ["Grade 5", "O/L", "A/L"],
      required: true,
    },
    subject: {
      type: String,
      required: true,
    },
    medium: {
      type: String,
      enum: ["Shinhala", "English"],
      required: true,
    },
    photosURL: {
      type: String,
      required: true,
    },

    pagelink: {
      type: String,
      required: true,
    },

    email: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoode.model("postuplo", postuplo);

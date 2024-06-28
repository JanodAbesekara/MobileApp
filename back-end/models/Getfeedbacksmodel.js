import mongoose from "mongoose";

const { Schema } = mongoose;

const GetfeedbacksSchema = new Schema(
  {
    feedtext: {
      type: String,
      required: true,
    },
    studentemail: {
      type: String,
      required: true,
    },
    teacheremail: {
      type: String,
      required: true,
    },
    feedSubject:{
      type: String,
      required: true,
    },  
    feedmedium:{
      type: String,
      required: true,
    },
    value: {
      type: Number,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model("Getfeedbacks", GetfeedbacksSchema);

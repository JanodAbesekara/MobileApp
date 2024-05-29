import mongoose from "mongoose";
const { Schema } = mongoose;

const marksModel = new Schema(
    {
      email: {
        type: String,
      },
      subject: {
        type: String,
      },
      score: {
        type: String,
      },
    },
    {
      timestamps: true,
    }
  );
  
  export default mongoose.model("marksForGrading", marksModel);
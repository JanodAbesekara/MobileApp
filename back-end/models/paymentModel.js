import mongoose from "mongoose";

const {Schema} = mongoose;

const paymentSchema = new Schema (
    {
        
    id: {
        type: String,
        required: true,
      },
    bank: {
        type: String,
        required: true,
      },
      accountNo: {
        type: String,
        required: true,
      },
    },
    {
        timestamps: true,
    }
);

export default mongoose.model("teacher/paymentDetails",paymentSchema);
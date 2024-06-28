import  Mongoose  from "mongoose";
const { Schema } =  Mongoose;

const Messagemodel = new Schema(
  {
    chatId: {
      type: String,
    },
    senderId: {
      type: String,
    },
    message: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);

export default Mongoose.model("Message", Messagemodel);

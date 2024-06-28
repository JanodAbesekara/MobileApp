import  Mongoose  from "mongoose";


const Chatschema = Mongoose.Schema(
  {
    members: {
      type: Array,
    },
  },
  {
    timestamps: true,
  }
);

export default Mongoose.model("Chat", Chatschema);

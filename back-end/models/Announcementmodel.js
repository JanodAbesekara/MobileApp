import mongoose from "mongoose";
const { Schema } = mongoose;

const announcementSchema = new Schema(
  {
    jobrole: {
      type: String,
      required: true,
    },
    postedemail: {
      type: String,
      required: true,
    },

    TeacheSubject: {
      type: String,
      default:function () {
        return this.jobrole === "Admin" ? "System change" : "";
      },
    },
    mediua: {
      type: String,
      default:function () {
        return this.jobrole === "Admin" ? "System" : "";
      },
    },
    Announcementmessage: {
      type: String,
      required: true,
    },
    titleofAnn: {
      type: String,
      required: true,
    },
    date: {
      type: Date,
      default: Date.now,
    },

    time: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

const Announcement = mongoose.model("Announcement", announcementSchema);
export default Announcement;

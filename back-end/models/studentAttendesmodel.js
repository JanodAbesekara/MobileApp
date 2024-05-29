import mongoose from "mongoose";

const{Schema} = mongoose;

const attendennceSchema = new Schema({

    studentnemail:{
        type: String,
        required: true
    },
    studentname:{
        type: String,
        required: true
    },
    subject:{
        type: String,
        required: true
    },
    medium:{
        type: String,
        required: true
    },
    teachetmail:{
        type: String,
        required: true
    },
    countAttendence:{
        type: Number,
        required: true
    },
   },
    {
        timestamps: true
    }
    

);

export default mongoose.model("studentAttendes", attendennceSchema);
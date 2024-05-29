import mongoose from "mongoose"

const { Schema } = mongoose;

const studentProfileSchema = new Schema({
    name:{
        type:String,
        required:true
    },
    email:{
        type:String,
        required:true
    },
    mobileNo:{
        type:Number,
        required:true
    },
    uEmail:{
        type:String,
        required:true
    },
    id:{
        type:String
    },
},
{
    timestamps: true,
});


export default mongoose.model("studentsParentDetail",studentProfileSchema);
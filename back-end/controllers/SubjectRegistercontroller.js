import profileSchema from "../models/userProfileModel.js";


const getRegisteredSubject = async(req,res) => {
   const { email } = req.query;

  try{
    const registeredSubjects = await profileSchema.find( { email: email });
    return res.status(200).json({success:true, data:registeredSubjects});
  }catch(error){
    return res.status(500).json({success:false,msg:"Internal Server Error"});
  }
   
};

const getSubject = async(req,res) => {
   const email = req.params.teacherEmail;

  try{
    const registeredSubjects = await profileSchema.find( { email: email });
    return res.status(200).json({success:true, data:registeredSubjects});
  }catch(error){
    return res.status(500).json({success:false,msg:"Internal Server Error"});
  }
   
};

export {getRegisteredSubject,getSubject};
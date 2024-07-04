import 'dart:convert';

import 'package:dream_learn_app/helpers/student_helper.dart';
import 'package:dream_learn_app/models/quiz.dart';
import 'package:dream_learn_app/models/student_class_fee.dart';
import 'package:http/http.dart' as http;

class StudentService{
static Future<List<StudentClassFee>> getPayments(String studentEmail) async{
    var url =
        Uri.http('bytegroupproject.onrender.com', '/api/Test/getdetails',{'email':studentEmail});
    var response = await http.get(url);
    Map<String, dynamic> decodedJson= jsonDecode(response.body)  as Map<String, dynamic>;
    if(response.statusCode==200){
    return  (decodedJson['data'] as List).map((fee) =>StudentClassFee.fromJson(fee) ).toList();
    }else{
      throw Exception('cannot load class fees');
    }
}

   static Future<List<Quiz>> getAssignementList()async{
      var url = Uri.http('bytegroupproject.onrender.com', '/api/Test/getAssignment',{'email':studentEmail});
       var response =await http.get(url);
         Map decodedJson= jsonDecode(response.body)  as Map;
       if(response.statusCode==200){
      return  ((decodedJson['assignments']) as List).map((ques) => Quiz.fromJson(ques)).toList();
       }else{
        throw 'cannot get quiz list';
       }
  }

     static Future<List<Quiz>> getAnnouncementsList()async{
      var url = Uri.http('bytegroupproject.onrender.com', '/api/get/notifaction',{'email':studentEmail});
       var response =await http.get(url);
         Map decodedJson= jsonDecode(response.body)  as Map;
       if(response.statusCode==200){
      return  ((decodedJson['assignments']) as List).map((ques) => Quiz.fromJson(ques)).toList();
       }else{
        throw 'cannot get quiz list';
       }
  }

   static Future<bool> postFeedback(String feedtext, String value,String teacheremail,String feedSubject,String feedmedium) async {
    var url = Uri.https('bytegroupproject.onrender.com', '/api/auth/feedbackadd');

    try{
        // var response = await http.post(url, body: {'feedtext': feedtext, 'value': value,'studentemail':studentEmail,'teacheremail':teacheremail,'feedSubject':feedSubject,'feedmedium':feedmedium});
        var response = await http.post(url,body: {'feedtext': feedtext, 'value': value,'studentemail':studentEmail,'teacheremail':teacheremail,'feedSubject':feedSubject,'feedmedium':feedmedium});
    
    if (response.statusCode == 200) {
      return true;
      } else {
       return false;
      }
 
    }catch(err){
      return false;
    }
  

  }




}
import 'dart:convert';

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
}
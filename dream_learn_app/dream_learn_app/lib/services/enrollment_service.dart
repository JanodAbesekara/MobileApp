import 'dart:convert';

import 'package:dream_learn_app/models/subject.dart';
import 'package:http/http.dart' as http;

class EnrollmentService{
  static Future<List<Subject>> getSubjectList()async{
      var url = Uri.http('10.0.2.2:6000', '/api/Enrol/getSubject');
       var response =await http.get(url);
          Map<String, dynamic> decodedJson= jsonDecode(response.body)  as Map<String, dynamic>;
       if(response.statusCode==200){
      return  (decodedJson['data'] as List).map((subjectMap) => Subject.fromJson(subjectMap)).toList();
       }else{
        throw 'cannot get subject list';
       }
  }
}
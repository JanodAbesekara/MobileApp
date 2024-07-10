import 'dart:convert';
import 'package:dream_learn_app/helpers/domain_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:dream_learn_app/models/subject.dart';
import 'package:http/http.dart' as http;

class EnrollmentService{
  static Future<List<Subject>> getSubjectList()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    String? email = decodedToken['email'];

    if (email == null) {
      throw Exception('Email not found in token');
    }
//------------------------------------------------------>
      var url = Uri.http(domainUrl, '/api/Enrol/getSubject', {'userEmail': email});
       var response =await http.get(url);
          Map<String, dynamic> decodedJson= jsonDecode(response.body)  as Map<String, dynamic>;
       if(response.statusCode==200){
      return  (decodedJson['data'] as List).map((subjectMap) => Subject.fromJson(subjectMap)).toList();
       }else{
        throw 'cannot get subject list';
       }
  }
} 

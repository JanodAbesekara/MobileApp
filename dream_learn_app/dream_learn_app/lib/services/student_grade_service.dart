import 'dart:convert';
import 'package:dream_learn_app/helpers/domain_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
//import 'package:dream_learn_app/models/teacher.dart';
import 'package:dream_learn_app/models/Grade_model.dart';
import 'package:http/http.dart' as http;

class StudentService {
  static Future<List<GradeModel>> getGrades() async {
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
//---------------------------------------->
    var url = Uri.http(domainUrl, '/api/assignment/getGrade', {'email': email});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List decodedJson = jsonDecode(response.body) as List;
      print("Decoded JSON: $decodedJson");
      return decodedJson.map((grade) => GradeModel.fromJson(grade)).toList();
      // return decodedJson.map((grade) => GradeModel.fromJson(grade)).toList();
    } else {
      throw Exception('Failed to load grades, status code: ${response.statusCode}');
    }
  }
}

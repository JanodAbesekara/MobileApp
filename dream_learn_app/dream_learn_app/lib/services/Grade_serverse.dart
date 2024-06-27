import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class GradeService {
  static Future<List<GradeModel>> getGradeList() async {
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

    var url = Uri.http('bytegroupproject.onrender.com', '/api/user/getsubjectreg', {'email': email});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> gradeList = jsonDecode(response.body)['data'];
      List<GradeModel> results = [];

      for (var gradeMap in gradeList) {
        var gradeModel = GradeModel.fromJson(gradeMap);
        var studentGrades = await _fetchStudentGrades(
          email: email,
          subject: gradeModel.subject,
          medium: gradeModel.medium,
          teacherEmail: gradeModel.teacherEmail,
        );
        results.addAll(studentGrades);
      }

      return results;
    } else {
      throw Exception('Cannot get grade list');
    }
  }

  static Future<List<GradeModel>> _fetchStudentGrades({
    required String email,
    required String subject,
    required String medium,
    required String teacherEmail,
  }) async {
    var url = Uri.http('bytegroupproject.onrender.com', 'api/assignment/getStudentGrades', {
      'email': email,
      'subject': subject,
      'medium': medium,
      'teacheremail': teacherEmail,
    });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> studentGradesList = jsonDecode(response.body)['data'];
      return studentGradesList.map((gradeMap) => GradeModel.fromJson(gradeMap)).toList();
    } else {
      throw Exception('Cannot get student grades');
    }
  }
}

class GradeModel {
  final String subject;
  final String medium;
  final String teacherEmail;

  GradeModel({
    required this.subject,
    required this.medium,
    required this.teacherEmail,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      subject: json['subject'],
      medium: json['medium'],
      teacherEmail: json['teacheremail'],
    );
  }
}

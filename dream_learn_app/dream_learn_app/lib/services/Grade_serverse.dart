import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class GradeService {
  static Future<List<Map<String, dynamic>>?> getGradeList({
    required String teacherEmail,
    required String subject,
    required String medium,
  }) async {
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

    var url = Uri.http('bytegroupproject.onrender.com',
        '/api/assignment/getgradefromteacher', {'email': email});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        var responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('data')) {
          List<dynamic> gradeList = responseBody['data'];

          // Filter the grade list based on teacherEmail, subject, and medium
          List<Map<String, dynamic>> filteredGradeList = gradeList
              .cast<Map<String, dynamic>>()
              .where((grade) =>
                  grade['teacherEmail'] == teacherEmail &&
                  grade['subject'] == subject &&
                  grade['medium'] == medium)
              .toList();

          return filteredGradeList;
        } else {
          throw Exception('Data field not found in response');
        }
      } catch (e) {
        throw Exception('Error decoding JSON: $e');
      }
    } else {
      throw Exception('Cannot get grade list');
    }
  }
}

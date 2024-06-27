import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class StudentparentsService{
  static Future<List<Map<String, dynamic>>?> getStudentList() async {
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

    var url = Uri.http('bytegroupproject.onrender.com', '/api/assignment/eachsubstudents', {'email': email});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        var responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('data')) {
          List<dynamic> studentList = responseBody['data'];
          print(studentList);
          return studentList.cast<Map<String, dynamic>>();
        } else {
          throw Exception('Data field not found in response');
        }
      } catch (e) {
        throw Exception('Error decoding JSON: $e');
      }
    } else {
      throw Exception('Cannot get student list');
    }
  }
}
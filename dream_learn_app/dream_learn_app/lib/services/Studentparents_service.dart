import 'package:dream_learn_app/helpers/domain_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class StudentparentsService {
  static Future<List<Map<String, dynamic>>?> getStudentList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> decodedToken;
    try {
      decodedToken = Jwt.parseJwt(token);
    } catch (e) {
      throw Exception('Invalid token format: $e');
    }

    String? email = decodedToken['email'];
    if (email == null) {
      throw Exception('Email not found in token');
    }

    var url = Uri.http(domainUrl,
        '/api/assignment/eachsubstudents', {'email': email});
    
    http.Response response;
    try {
      response = await http.get(url);
    } catch (e) {
      throw Exception('Failed to send request: $e');
    }

    if (response.statusCode == 200) {
      var responseBody;
      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        throw Exception('Error decoding JSON: $e');
      }

      if (responseBody is Map<String, dynamic> &&
          responseBody.containsKey('data')) {
        List<dynamic> studentList = responseBody['data'];
      
        return studentList.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Data field not found in response');
      }
    } else {
      throw Exception(
          'Cannot get student list, status code: ${response.statusCode}');
    }
  }
}

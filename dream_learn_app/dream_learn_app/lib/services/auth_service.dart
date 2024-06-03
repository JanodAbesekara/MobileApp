import 'package:dream_learn_app/models/login_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthService {
  static Future<LoginDataModel> login(String email, String password) async {
    var url = Uri.parse('http://localhost:6000/api/auth/login');
    try {
      var response = await http.post(url, body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
        if (decodedJson['token'] != null) {
          return LoginDataModel(success: true, message: decodedJson['msg'], token: decodedJson['token']);
        } else {
          return LoginDataModel(success: false, message: decodedJson['msg']);
        }
      } else {
        return LoginDataModel(success: false, message: 'Failed to log in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error or handle it appropriately
      return LoginDataModel(success: false, message: 'An error occurred: $e');
    }
  }
}

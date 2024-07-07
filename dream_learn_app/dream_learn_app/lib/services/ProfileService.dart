import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileService {
  static Future<List<Map<String, dynamic>>?> getProfileDataFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    String? email = decodedToken['email'];

    if (email != null) {
      var url = Uri.parse(
          'https://bytegroupproject.onrender.com/api/Test/getlecturefulldtails?email=$email');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          var responseBody = jsonDecode(response.body);
          if (responseBody.containsKey('data')) {
            List<dynamic> profileList = responseBody['data'];
            return profileList.cast<Map<String, dynamic>>();
          } else {
            throw Exception('Data field not found in response');
          }
        } catch (e) {
          throw Exception('Error decoding JSON: $e');
        }
      } else {
        throw Exception('Cannot get profile data');
      }
    }
    return null;
  }

  static Future<Map<String, String>?> getNameFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    String? firstName = decodedToken['firstname'];
    String? lastName = decodedToken['lastname'];

    if (firstName != null && lastName != null) {
      return {'firstName': firstName, 'lastName': lastName};
    } else {
      throw Exception('First name or last name not found in token');
    }
  }
}


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class ProfileService {
  // Method to decode the token and get the email
  static Future<String?> getEmailFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    String? email = decodedToken['email'];

    if (email != null) {
      var url = Uri.http('bytegroupproject.onrender.com',
          '/api/Test/getlecturefulldtails', {'email': email});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          var responseBody = jsonDecode(response.body);
          if (responseBody.containsKey('data')) {
            List<dynamic> profileData = responseBody['data'];
            print(profileData);
            return profileData.cast<Map<String, dynamic>>().first['email'];
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
}

import 'package:dream_learn_app/models/Profiledata.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class ProfileService {
  // Method to decode the token and get the email
  static Future<String?> getEmailFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      return decodedToken['email'];
    }
    return null;
  }

  // Method to get profile data from the backend
  static Future<ProfileData?> getProfileData() async {
    String? email = await getEmailFromToken();

    if (email != null) {
      var url = Uri.http('bytegroupproject.onrender.com', '/api/user/getsubjectreg', {'email': email});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);
        return ProfileData.fromJson(decodedJson);
      } else {
        print("Error fetching profile data: ${response.body}");
        return null;
      }
    }
    return null;
  }
}

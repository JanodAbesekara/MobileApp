import 'package:dream_learn_app/helpers/domain_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class AttendenceService {
  static Future<List<Map<String, dynamic>>?> getAttendence() async {
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

    var url = Uri.http(domainUrl, '/api/user/getstudentattendence');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> attendenceList = jsonDecode(response.body)['data'];

      // Filter attendance based on decoded email
      List<Map<String, dynamic>> filteredAttendence = attendenceList
          .where((attendence) => attendence['profile'][0]['teacheremail'] == email)
          .map((attendence) => attendence as Map<String, dynamic>)
          .toList();

    
      return filteredAttendence;
     
    } else {
      print("Error fetching attendance data: ${response.body}");
      return null;
    }
  }
}

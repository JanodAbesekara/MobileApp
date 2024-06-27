import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class GradeService {
  static Future<List<Map<String, dynamic>>?> getGradeList() async {
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

    var url = Uri.http('bytegroupproject.onrender.com', '/api/assignment/getgradefromteacher', {'email': email});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> gradeList = jsonDecode(response.body)['data'];
      return gradeList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Cannot get grade list');
    }
  }
}

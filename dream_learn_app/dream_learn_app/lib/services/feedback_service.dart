import 'package:dream_learn_app/helpers/domain_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

class FeedbackService {
  static Future<List<Map<String, dynamic>>?> getFeedback() async {
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

    var url =
        Uri.http(domainUrl, '/api/auth/feedbackget');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> feedbackList = jsonDecode(response.body)['data'];

      // Filter feedback based on decoded email
      List<Map<String, dynamic>> filteredFeedback = feedbackList
          .where((feedback) {
            return feedback['teacheremail'] == email;
          })
          .map((feedback) => feedback as Map<String, dynamic>)
          .toList();

      return filteredFeedback;
    } else {
      print("Error fetching feedback data: ${response.body}");
      return null;
    }
  }
}


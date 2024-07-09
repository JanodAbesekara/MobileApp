import 'dart:convert';
import 'package:dream_learn_app/models/teacher.dart';
import 'package:http/http.dart' as http;

class TeacherService {
  static Future<List<Teacher>> getTeachers({String? email, String? subject, String? medium}) async {
    var queryParams = {
      if (email != null) 'email': email,
      if (subject != null) 'subject': subject,
      if (medium != null) 'medium': medium,
    };

    var url = Uri.http('bytegroupproject.onrender.com', '/api/auth/teachermangement', queryParams);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List decodedJson = jsonDecode(response.body)['data'] as List;
      List<Teacher> teachers = decodedJson.map((teacher) => Teacher.fromJson(teacher)).toList();

      // Fetch profile URLs in parallel
      await Future.wait(teachers.map((teacher) async {
        teacher.url = await fetchProfileUrl(teacher.email, subject, medium);
      }));

      return teachers;
    } else {
      throw 'Cannot get teacher list';
    }
  }

  static Future<String?> fetchProfileUrl(String? email, String? subject, String? medium) async {
    if (email == null) return null;

    var queryParams = {
      'email': email,
      if (subject != null) 'subject': subject,
      if (medium != null) 'medium': medium,
    };

    var url = Uri.http('bytegroupproject.onrender.com', '/api/Test/profileget', queryParams);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return data['url'] as String?;
    } else if (response.statusCode == 404) {
      return null; // Profile not found
    } else {
      throw 'Cannot get profile URL';
    }
  }
}

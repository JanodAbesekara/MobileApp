import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dream_learn_app/helpers/student_helper.dart';

class AnnouncementServices {
  static Future<List<Map<String, dynamic>>?> getStudentAnnouncement() async {
    var url = Uri.http('bytegroupproject.onrender.com', '/api/get/notifaction', {'email': studentEmail});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Print the entire response body for debugging
      print("Response Body: ${response.body}");

      // Parse the response body
      var data = jsonDecode(response.body);
      List<dynamic> announcements = data['announcements'] ?? [];
      List<dynamic> announceme = data['announceme'] ?? [];

      // Combine announcements and announceme into a single list
      List<Map<String, dynamic>> mappedAnnouncements = [
        ...announcements.map((item) => item as Map<String, dynamic>),
        ...announceme.map((item) => item as Map<String, dynamic>)
      ];

      print("Mapped Data: $mappedAnnouncements");
      return mappedAnnouncements;
    } else {
      print("Error fetching student announcement data: ${response.body}");
      return null;
    }
  }
}

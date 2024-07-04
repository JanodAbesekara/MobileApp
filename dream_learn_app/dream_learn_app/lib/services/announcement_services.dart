import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dream_learn_app/helpers/student_helper.dart';

class AnnouncementServices {
  static Future<List<Map<String, dynamic>>?> getAnnouncement() async {
    var url = Uri.http('bytegroupproject.onrender.com', '/api/get/Notifactions');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Print the entire response body for debugging

      List<dynamic> announcementList = jsonDecode(response.body)['announcements'];

      // Convert each item in announcementList to Map<String, dynamic>
      List<Map<String, dynamic>> mappedAnnouncements = announcementList
          .map((announcement) => announcement as Map<String, dynamic>)
          .toList();
      
      return mappedAnnouncements;
    } else {
      print("Error fetching announcement data: ${response.body}");
      return null;
    }
  }

    static Future<List<Map<String, dynamic>>?> getStudentAnnouncement() async {
    var url = Uri.http('bytegroupproject.onrender.com', '/api/get/Notifactions',{'email':studentEmail});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Print the entire response body for debugging
      print("Response Body: ${response.body}");

      List<dynamic> announcementList = jsonDecode(response.body)['announcements'];

      // Convert each item in announcementList to Map<String, dynamic>
      List<Map<String, dynamic>> mappedAnnouncements = announcementList
          .map((announcement) => announcement as Map<String, dynamic>)
          .toList();
      print( "Maqpping data : ${mappedAnnouncements}");
      return mappedAnnouncements;
    } else {
      print("Error fetching announcement data: ${response.body}");
      return null;
    }
  }



}

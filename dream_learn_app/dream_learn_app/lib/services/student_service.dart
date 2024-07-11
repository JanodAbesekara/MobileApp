import 'dart:convert';
import 'package:dream_learn_app/helpers/domain_helper.dart';
import 'package:dream_learn_app/helpers/student_helper.dart';
import 'package:dream_learn_app/models/quiz.dart';
import 'package:dream_learn_app/models/student_class_fee.dart';
import 'package:http/http.dart' as http;

class StudentService {
  static Future<bool> postPayment({
    required String photoUrl,
    required String teacherEmail,
    required String subject,
    required String medium,
    required String bankName,
    required String accountNo,
    // required String email,
  }) async {
    var url = Uri.http(domainUrl, '/api/Test/poststudentpayment');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'photourl': photoUrl,
          'TeacherEmail': teacherEmail,
          'stuemail': studentEmail,
          'Subject': subject,
          'medium': medium,
          'Bankname': bankName,
          'AccountNum': accountNo,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Error posting payment: $err');
      return false;
    }
  }

  static Future<List<StudentClassFee>> getPayments() async {
    var url =
        Uri.http(domainUrl, '/api/Test/getdetails', {'email': studentEmail});
    var response = await http.get(url);
    Map<String, dynamic> decodedJson =
        jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return (decodedJson['data'] as List)
          .map((fee) => StudentClassFee.fromJson(fee))
          .toList();
    } else {
      throw Exception('cannot load class fees');
    }
  }

  static Future<List<Quiz>> getAssignementList() async {
    var url =
        Uri.http(domainUrl, '/api/Test/getAssignment', {'email': studentEmail});
    var response = await http.get(url);
    Map decodedJson = jsonDecode(response.body) as Map;
    if (response.statusCode == 200) {
      return ((decodedJson['assignments']) as List)
          .map((ques) => Quiz.fromJson(ques))
          .toList();
    } else {
      throw 'cannot get quiz list';
    }
  }

  static Future<List<Quiz>> getAnnouncementsList() async {
    var url =
        Uri.http(domainUrl, '/api/get/notifaction', {'email': studentEmail});
    var response = await http.get(url);
    Map decodedJson = jsonDecode(response.body) as Map;
    if (response.statusCode == 200) {
      return ((decodedJson['assignments']) as List)
          .map((ques) => Quiz.fromJson(ques))
          .toList();
    } else {
      throw 'cannot get quiz list';
    }
  }

  static Future<bool> postFeedback(String feedtext, String value,
      String teacheremail, String feedSubject, String feedmedium) async {
    var url = Uri.http(domainUrl, '/api/auth/feedbackadd');

    try {
      // var response = await http.post(url, body: {'feedtext': feedtext, 'value': value,'studentemail':studentEmail,'teacheremail':teacheremail,'feedSubject':feedSubject,'feedmedium':feedmedium});
      var response = await http.post(url, body: {
        'feedtext': feedtext,
        'value': value,
        'studentemail': studentEmail,
        'teacheremail': teacheremail,
        'feedSubject': feedSubject,
        'feedmedium': feedmedium
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}

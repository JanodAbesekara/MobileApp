import 'package:dream_learn_app/models/lecture_material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LectureMaterialService {
  static Future<List<LectureMaterial>> getLectureMaterials(
      String teacherEmail, String subject, String medium) async {
    var url = Uri.http('bytegroupproject.onrender.com', '/api/Test/getlecturematerial',
        {'teachermail': teacherEmail, 'subject': subject, 'medium': medium});
    var response = await http.get(
      url,
    );
    Map<String, dynamic> decodedJson =
        jsonDecode(response.body) as Map<String, dynamic>;
    final lecMaterialList = decodedJson['data'] as List;

    if (response.statusCode == 200) {
      return lecMaterialList
          .map((item) => LectureMaterial.fromJson(item))
          .toList();

      print(lecMaterialList);
    } else {
      throw 'cannot load lecture materials';
    }
  }
}

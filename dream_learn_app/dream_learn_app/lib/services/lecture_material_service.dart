import 'package:dream_learn_app/models/lecture_material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LectureMaterialService{
  static Future<List<LectureMaterial>> getLectureMaterials(String teacherEmail,String subject,String medium)async{
  var url = Uri.http('10.0.2.2:6000', '/api/Quise/getlecturematerial');
  var response =await http.post(url, body: {'teacheremail':teacherEmail , 'subject':subject,'medium':medium });
   Map<String, dynamic> decodedJson= jsonDecode(response.body)  as Map<String, dynamic>;
   final lecMaterialList= decodedJson['data'] as List;

  if(response.statusCode==200){
  return lecMaterialList.map((item) => LectureMaterial.fromJson(item)).toList();
   
  
  }else{
    throw 'cannot load lecture materials';
  }

 




 }
}
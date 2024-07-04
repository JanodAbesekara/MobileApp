import 'dart:convert';
import 'package:dream_learn_app/models/teacher.dart';
import 'package:http/http.dart' as http;
class TeacherService{
static Future<List<Teacher>> getTeachers()async{
  var url = Uri.http('bytegroupproject.onrender.com', '/api/auth/teachermangement');
       var response =await http.get(url);
         List decodedJson= jsonDecode(response.body)['data']  as List;
       if(response.statusCode==200){
      return  decodedJson.map((teacher) => Teacher.fromJson(teacher)).toList();
       }else{
        throw 'cannot get teacher list';
       }
}
}
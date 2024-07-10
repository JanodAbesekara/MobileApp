import 'dart:convert';

import 'package:dream_learn_app/helpers/domain_helper.dart';
import 'package:dream_learn_app/models/quiz.dart';
import 'package:http/http.dart' as http;

class QuizService{
   static Future<List<Quiz>> getQuizList()async{
      var url = Uri.http(domainUrl, '/api/Quise/getQuise');
       var response =await http.get(url);
         List decodedJson= jsonDecode(response.body)  as List;
       if(response.statusCode==200){
      return  decodedJson.map((ques) => Quiz.fromJson(ques)).toList();
       }else{
        throw 'cannot get quiz list';
       }
  }
}
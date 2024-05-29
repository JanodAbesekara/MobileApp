import 'package:dream_learn_app/models/login_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService{

  
static Future<LoginDataModel> login(String email,String password)async{
  var url = Uri.http('http://localhost:9804:6000', '/api/auth/login');
  var response =await http.post(url, body: {'email':email , 'password':password });
   Map<String, dynamic> decodedJson= jsonDecode(response.body)  as Map<String, dynamic>;

  if(response.statusCode==200){
 
    if(decodedJson['token'] !=null){
      return LoginDataModel(success: true,message:decodedJson['msg'],token: decodedJson['token'] );


    }
  
  }else{
    return LoginDataModel(success: false,message:decodedJson['msg']);
  }

  return  LoginDataModel(success: false,message:decodedJson['msg']);




 }


}
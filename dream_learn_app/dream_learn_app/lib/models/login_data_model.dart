class LoginDataModel{
  bool success;
  String message;
  String? token;

  LoginDataModel({required this.message,required this.success,this.token});

}
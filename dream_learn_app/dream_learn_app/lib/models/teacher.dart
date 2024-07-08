class Teacher{
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? url;
  DateTime? date;

  Teacher.fromJson(Map<String,dynamic> json){
    firstName=json['firstname'];
    lastName= json['lastname'];
    email=json['email'];
    phoneNumber= json['phonenumber'];
    url=json['url'];
    date= DateTime.tryParse(json['createdAt']) ;

  }
}
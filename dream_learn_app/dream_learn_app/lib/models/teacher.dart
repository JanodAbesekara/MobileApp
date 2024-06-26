class Teacher{
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? date;

  Teacher.fromJson(Map<String,dynamic> json){
    firstName=json['firstname'];
    lastName= json['lastname'];
    email=json['email'];
    phoneNumber= json['phonenumber'];
    date= DateTime.tryParse(json['createdAt']) ;

  }
}
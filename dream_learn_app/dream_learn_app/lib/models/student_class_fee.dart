class StudentClassFee{
  String? teacherEmail;
  String? bankName;
  String? accountNo;
  String? classFee;
  String? subject;
  String? medium;

  StudentClassFee.fromJson(Map<String,dynamic> json){
   teacherEmail=   json['payment']['TeacherEmail'];
   bankName=   json['payment']['bank'];
    accountNo=  json['payment']['accountNo'];
       classFee=   json['classpees'];
       subject = json['subject'];
       medium=json['medium'];
    
  }

}
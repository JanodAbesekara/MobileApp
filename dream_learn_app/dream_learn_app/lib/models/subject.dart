class Subject{
  String? subjectName;
  String? medium;
  DateTime? date;
String? email;
String? teacherEmail;

  Subject.fromJson(Map<String,dynamic> json){
    subjectName=json['Ensubject'];
    medium=json['Enmedium'];
    date=DateTime.tryParse(json['createdAt']
    
    );
     teacherEmail=json['teacherEmail'];
    email=json['userEmail'];

  }





 }
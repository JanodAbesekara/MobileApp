class StudentClassFee {
  String? teacherEmail;
  String? bankName;
  String? accountNo;
  String? classFee;
  String? subject;
  String? medium;

  StudentClassFee.fromJson(Map<String, dynamic> json) {
    teacherEmail = json['payment'] != null ? json['payment']['TeacherEmail'] : null;
    bankName = json['payment'] != null ? json['payment']['bank'] : null;
    accountNo = json['payment'] != null ? json['payment']['accountNo'] : null;
    classFee = json['classpees'];
    subject = json['subject'];
    medium = json['medium'];
  }
}

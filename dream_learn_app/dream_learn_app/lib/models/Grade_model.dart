class GradeModel{
    final String email;
  final String subject;
  final String medium;
  final int grade;
  GradeModel({
    required this.email,
    required this.subject,
    required this.medium,
    required this.grade,
  });
  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      email: json['email'],
      subject: json['subject'],
      medium: json['medium'],
      grade: json['grade'],
    );
  }
}
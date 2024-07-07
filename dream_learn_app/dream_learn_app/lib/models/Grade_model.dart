class GradeModel{
    final String email;
  final String subject;
  final String medium;
  final String grade;
  final int score;

  GradeModel({
    required this.email,
    required this.subject,
    required this.medium,
    required this.grade,
    required this.score,

  });
  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      email: json['email'],
      subject: json['subject'],
      medium: json['medium'],
      grade: json['grade'],
      score: json['score'],
    );
  }
   @override
  String toString() {
    return '{email: $email, subject: $subject, medium: $medium, grade: $grade, score: $score}';
  }
}
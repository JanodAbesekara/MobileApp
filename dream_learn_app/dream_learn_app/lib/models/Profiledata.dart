class ProfileData {
  final String email;
  final String firstName;
  final String lastName;
  final List<String> subjects;

  ProfileData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.subjects,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      subjects: List<String>.from(json['subjects']),
    );
  }
}

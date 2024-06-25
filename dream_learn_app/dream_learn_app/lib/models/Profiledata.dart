class ProfileData {
  final List<String> classes;

  ProfileData({
    required this.classes,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      classes: List<String>.from(json['classes']),
    );
  }
}

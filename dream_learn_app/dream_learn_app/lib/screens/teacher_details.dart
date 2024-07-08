import 'package:dream_learn_app/models/teacher.dart';
import 'package:dream_learn_app/services/teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeacherDetails extends StatelessWidget {
  final String? teacherEmail;
  final String? subject;
  final String? medium;

  const TeacherDetails({required this.teacherEmail, required this.subject, required this.medium, super.key});

  Future<Teacher> _getTeacherDetails() async {
    List<Teacher> teacherList = await TeacherService.getTeachers(email: teacherEmail, subject: subject, medium: medium);
    final Teacher teacher;
    try {
      teacher = teacherList.firstWhere((teacher) => teacher.email == teacherEmail);
      return teacher;
    } catch (err) {
      throw 'Teacher cannot be found';
    }
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 20),
        Text(
          '$title: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      ),
      body: FutureBuilder<Teacher>(
        future: _getTeacherDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Image(
                image: AssetImage('assets/loading.gif'),
                width: 100,
                height: 100,
              ),
            );
          } else if (snapshot.hasError) {
            print('Error loading teacher details: ${snapshot.error}');
            return const Center(child: Text('Error loading teacher details'));
          } else if (snapshot.hasData) {
            Teacher teacher = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  CircleAvatar(
                    radius: 78,
                    backgroundColor: Colors.blueAccent,
                    child: FutureBuilder<String?>(
                      future: TeacherService.fetchProfileUrl(teacher.email, subject, medium),
                      builder: (context, profileSnapshot) {
                        if (profileSnapshot.connectionState == ConnectionState.waiting) {
                          return CircleAvatar(
                            radius: 75,
                            backgroundImage: AssetImage('assets/loading.gif'), // Placeholder loading image
                          );
                        } else if (profileSnapshot.hasError) {
                          return CircleAvatar(
                            radius: 75,
                            backgroundImage: AssetImage('assets/profile_avatar.png'), // Placeholder error image
                          );
                        } else if (profileSnapshot.hasData && profileSnapshot.data != null) {
                          return CircleAvatar(
                            radius: 75,
                            backgroundImage: NetworkImage(profileSnapshot.data!),
                          );
                        } else {
                          return CircleAvatar(
                            radius: 75,
                            backgroundImage: AssetImage('assets/profile_avatar.png'), // Default placeholder image
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${teacher.firstName} ${teacher.lastName}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(Icons.phone, 'Number', teacher.phoneNumber ?? 'N/A'),
                          const SizedBox(height: 20),
                          _infoRow(Icons.email, 'Email', teacher.email ?? 'N/A'),
                          const SizedBox(height: 20),
                          _infoRow(Icons.date_range, 'Joined on', teacher.date != null
                              ? DateFormat('d MMMM yyyy, h:mm a').format(teacher.date!)
                              : 'N/A'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No Teacher Found'));
          }
        },
      ),
    );
  }
}

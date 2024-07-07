import 'package:dream_learn_app/models/teacher.dart';
import 'package:dream_learn_app/models/Grade_model.dart';
import 'package:dream_learn_app/services/student_grade_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentGrades extends StatelessWidget {
  final String teacherEmail;
  final String subject;
  final String medium;
  const StudentGrades({required this.teacherEmail, required this.subject, required this.medium  ,super.key});

  Future<List<GradeModel>> _getGradeDetails() async {
    try {
      List<GradeModel> gradeList = await StudentService.getGrades();
      print(gradeList);

      return gradeList;
    } catch (e) {
      print("Error in _getGradeDetails: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grades'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<GradeModel>>(
        future: _getGradeDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Error loading subject list: ${snapshot.error}');
            return Center(child: Text('Error loading subject list: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Text(
                              item.grade,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Subject: ${item.subject}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Medium: ${item.medium}', style: const TextStyle(fontSize: 16)),
                                Text('Score: ${item.score}', style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


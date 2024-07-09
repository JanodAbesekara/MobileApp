import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/services/attendence_service.dart';
import 'package:dream_learn_app/models/Grade_model.dart';
import 'package:dream_learn_app/services/student_grade_service.dart';

class AttendenceT extends StatelessWidget {
  const AttendenceT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students attendance'),
        backgroundColor: Colors.blue,
      ),
      body: _passChild(context),
    );
  }

  Widget _passChild(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: AttendenceService.getAttendence(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No attendance available'));
        } else {
          List<Map<String, dynamic>> attendenceList = snapshot.data!;
          return ListView.builder(
            itemCount: attendenceList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> attendance = attendenceList[index];
              return AttendenceCard(
                name: attendance['posts']['studentname'],
                email: attendance['posts']['studentnemail'],
                subject: attendance['posts']['subject'],
                medium: attendance['posts']['medium'],
                attendancePercentage: (attendance['posts']['countAttendence'] /
                        attendance['profile'][0]['leccount']) *
                    100,
              );
            },
          );
        }
      },
    );
  }
}

class AttendenceCard extends StatelessWidget {
  final String name;
  final String email;
  final String subject;
  final String medium;
  final double attendancePercentage;

  const AttendenceCard({
    Key? key,
    required this.name,
    required this.email,
    required this.subject,
    required this.medium,
    required this.attendancePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // Changed to white color
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Student Name:', name),
          _buildRowWithNewLine('Student Email:', email),
          _buildRow('Subject:', subject),
          _buildRow('Medium:', medium),
          _buildRow(
            'Attendance Percentage:',
            '${attendancePercentage.toStringAsFixed(2)}%',
            progressIndicator: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool progressIndicator = false}) {
    return Row(
      children: [
        Text(
          '$label ',
          style: GoogleFonts.lora(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        if (progressIndicator) ...[
          SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: attendancePercentage / 100,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(
                attendancePercentage >= 90
                    ? Colors.blue
                    : attendancePercentage >= 75
                        ? Colors.green
                        : attendancePercentage >= 50
                            ? Colors.yellow
                            : Colors.red,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRowWithNewLine(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: GoogleFonts.lora(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class StudentGrades extends StatelessWidget {
  final String teacherEmail;

  const StudentGrades({required this.teacherEmail, Key? key});

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

  Color getGradeColor(String gradeLabel) {
    switch (gradeLabel) {
      case 'W':
        return const Color.fromARGB(255, 236, 135, 128);
      case 'C':
        return const Color.fromARGB(255, 239, 227, 127);
      case 'B':
        return const Color.fromARGB(255, 137, 106, 232);
      case 'A':
        return const Color.fromARGB(255, 106, 232, 137);
      default:
        return Colors.white;
    }
  }

  String getGradeLabel(int score) {
    if (score >= 75) {
      return 'A';
    } else if (score >= 65 && score < 75) {
      return 'B';
    } else if (score >= 55 && score < 65) {
      return 'C';
    } else if (score >= 45 && score < 55) {
      return 'D';
    } else {
      return 'W';
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
            return Center(
                child: Text('Error loading subject list: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                String gradeLabel = getGradeLabel(item.score);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
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
                            backgroundColor: getGradeColor(gradeLabel),
                            child: Text(
                              gradeLabel,
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
                                  style: GoogleFonts.lora(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Medium: ${item.medium}',
                                  style: GoogleFonts.lora(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Score: ${item.score}%',
                                  style: GoogleFonts.lora(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
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

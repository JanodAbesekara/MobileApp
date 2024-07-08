import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/services/Grade_serverse.dart';

class GradeT extends StatelessWidget {
  const GradeT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Grades'),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: _passChild(context),
    );
  }

  Widget _passChild(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: GradeService.getGradeList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data found'));
        } else {
          List<Map<String, dynamic>> gradeList = snapshot.data!;
          return ListView.builder(
            itemCount: gradeList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> grade = gradeList[index];
              return GradeCard(
                email: grade['email'],
                name: grade['name'],
                subject: grade['subject'],
                medium: grade['medium'],
                grade: grade['grade'],
                score: grade['score'],
              );
            },
          );
        }
      },
    );
  }
}

class GradeCard extends StatelessWidget {
  final String email;
  final String name;
  final String subject;
  final String medium;
  final String grade; // Ensure grade is of type String
  final int score;

  const GradeCard({
    Key? key,
    required this.email,
    required this.name,
    required this.subject,
    required this.medium,
    required this.grade, // Ensure grade is of type String
    required this.score,
  }) : super(key: key);

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
    String gradeLabel = getGradeLabel(score);
    Color cardColor = getGradeColor(gradeLabel);

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
                backgroundColor: cardColor,
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
                      name,
                      style: GoogleFonts.lora(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: 'Email: ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: email,
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Medium: ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: medium,
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Subject: ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: subject,
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Score: ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '$score%',
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
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
  }
}

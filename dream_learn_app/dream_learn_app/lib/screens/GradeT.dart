import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/services/Grade_serverse.dart';

class GradeT extends StatelessWidget {
  const GradeT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundScreen(
            child: _passChild(context),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
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
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
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
            ),
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

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                '$name',
                style: GoogleFonts.lora(
                  fontSize: 16,
                ),
              ),
              Text(
                '$gradeLabel',
                style: GoogleFonts.lora(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$email',
                style: GoogleFonts.lora(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$medium',
                style: GoogleFonts.lora(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$subject',
                style: GoogleFonts.lora(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

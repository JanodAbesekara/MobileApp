import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/services/Grade_serverse.dart'; // Adjust the import path based on your project structure

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
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var gradeData = snapshot.data![index];
              return gradecards(
                email: gradeData['email'],
                subject: gradeData['subject'],
                medium: gradeData['medium'],
                grade: gradeData['grade'],
              );
            },
          );
        }
      },
    );
  }
}

class gradecards extends StatelessWidget {
  final String email;
  final String subject;
  final String medium;
  final int grade;

  const gradecards({
    Key? key,
    required this.email,
    required this.subject,
    required this.medium,
    required this.grade,
  }) : super(key: key);

  Color getGradeColor(String gradeLabel) {
    switch (gradeLabel) {
      case 'F':
        return const Color.fromARGB(255, 236, 135, 128);
      case 'C':
        return Color.fromARGB(255, 239, 227, 127);
      case 'B':
        return Color.fromARGB(255, 137, 106, 232);
      case 'A':
      case 'A+':
        return const Color.fromARGB(255, 119, 203, 243);
      default:
        return Colors.white;
    }
  }

  String getGradeLabel(int grade) {
    if (grade < 35) {
      return 'F';
    } else if (grade >= 35 && grade < 65) {
      return 'C';
    } else if (grade >= 65 && grade < 75) {
      return 'B';
    } else if (grade >= 75 && grade < 90) {
      return 'A';
    } else {
      return 'A+';
    }
  }

  @override
  Widget build(BuildContext context) {
    String gradeLabel = getGradeLabel(grade);
    Color cardColor = getGradeColor(gradeLabel);

    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'StudentEmail :- $email',
                style: GoogleFonts.lora(
                  fontSize: 16,
                ),
              ),
              Text(
                'Grade :- $gradeLabel',
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
                'Medium :- $medium',
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
                'Subject :- $subject',
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

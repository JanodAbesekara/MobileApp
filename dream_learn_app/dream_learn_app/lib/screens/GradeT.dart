import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

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
    return Column(
      children: [
        gradecards(
          email: 'asd@agmail.com',
          subject: "Maths",
          medium: 'English',
          grade: 80,
        ),
        gradecards(
          email: 'sfsdf@zdfdf',
          subject: "Science",
          medium: 'English',
          grade: 50,
        ),
        gradecards(
          email: 'sfsdf@zdfdf',
          subject: "Science",
          medium: 'English',
          grade: 100,
        ),
        gradecards(
          email: 'sfsdf@zdfdf',
          subject: "Science",
          medium: 'English',
          grade: 20,
        ),
        gradecards(
          email: 'sfsdf@zdfdf',
          subject: "Science",
          medium: 'English',
          grade: 67,
        ),
      ],
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
        return Colors.red;
      case 'C':
        return Colors.yellow;
      case 'B':
        return Colors.blue;
      case 'A':
      case 'A+':
        return Colors.lightBlue;
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
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
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
                'Email: $email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Subject: $subject',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medium: $medium',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Grade: $gradeLabel', // Displaying grade label
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

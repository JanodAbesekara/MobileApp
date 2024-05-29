import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendenceT extends StatelessWidget {
  const AttendenceT({Key? key}) : super(key: key);

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
        AttendenceCard(
          email: 'sdada@gmail.com',
          subject: "Maths",
          medium: 'English',
          attendancePercentage: 80,
        ),
        AttendenceCard(
          email: 'cdsfd@zdfdf',
          subject: "Science",
          medium: 'English',
          attendancePercentage: 90,
        ),
        AttendenceCard(
          email: 'cdsfd@zdfdf',
          subject: "Science",
          medium: 'English',
          attendancePercentage: 50,
        ),
        AttendenceCard(
          email: 'cdsfd@zdfdf',
          subject: "Science",
          medium: 'English',
          attendancePercentage: 10,
        ),
        AttendenceCard(
          email: 'cdsfd@zdfdf',
          subject: "Science",
          medium: 'English',
          attendancePercentage: 30,
        ),
        AttendenceCard(
          email: 'cdsfd@zdfdf',
          subject: "Science",
          medium: 'English',
          attendancePercentage: 60,
        ),
      ],
    );
  }
}

class AttendenceCard extends StatelessWidget {
  final String email;
  final String subject;
  final String medium;
  final int attendancePercentage;
  const AttendenceCard({
    Key? key,
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
        color: Colors.white,
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
        children: [
          Row(
            children: [
              Text(
                'StudentEmail :- ',
                style: GoogleFonts.lora(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222831),
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Subject :- ',
                style: GoogleFonts.lora(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222831),
                ),
              ),
              Text(
                subject,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Medium :- ',
                style: GoogleFonts.lora(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222831),
                ),
              ),
              Text(
                medium,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Attendance Percentage :- ',
                style: GoogleFonts.lora(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222831),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: LinearProgressIndicator(
                  value: attendancePercentage / 100,
                  backgroundColor: Colors.grey,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(attendancePercentage >= 90
                          ? Colors.blue
                          : attendancePercentage >= 75
                              ? Colors.green
                              : attendancePercentage >= 50
                                  ? Colors.yellow
                                  : Colors.red),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '$attendancePercentage%',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/services/attendence_service.dart';

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
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: attendenceList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> attendance = attendenceList[index];
                return AttendenceCard(
                  email: attendance['posts']['studentnemail'],
                  subject: attendance['posts']['subject'],
                  medium: attendance['posts']['medium'],
                  attendancePercentage: (attendance['posts']['countAttendence'] / attendance['profile'][0]['leccount']) * 100,
                );
              },
            ),
          );
        }
      },
    );
  }
}

class AttendenceCard extends StatelessWidget {
  final String email;
  final String subject;
  final String medium;
  final double attendancePercentage;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Student Email:', email),
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
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222831),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13),
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
}

import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/services/Studentparents_service.dart';

class StudentT extends StatelessWidget {
  const StudentT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackgroundScreen(
              child: _buildFutureBuilder(context),
            ),
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

  Widget _buildFutureBuilder(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: StudentparentsService.getStudentList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No students found'));
        } else {
          List<Map<String, dynamic>> studentList = snapshot.data!;
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> student = studentList[index];
                final profile = student['profile'] ?? {};
                if (student['userEmail'] == null ||
                    student['Ensubject'] == null ||
                    student['Enmedium'] == null) {
                  return SizedBox.shrink();
                }
                return StudentCard(
                  profile: profile['url'] ?? 'assets/profile_avatar.png',
                  subject: student['Ensubject'] ?? 'N/A',
                  studentEmail: student['userEmail'] ?? 'N/A',
                  medium: student['Enmedium'] ?? 'N/A',
                  parentsName: profile['name'] ?? 'N/A',
                  parentsPhone: profile['mobileNo']?.toString() ?? 'N/A',
                  parentsEmail: profile['email'] ?? 'N/A',
                );
              },
            ),
          );
        }
      },
    );
  }
}

class StudentCard extends StatelessWidget {
  final String profile;
  final String subject;
  final String studentEmail;
  final String medium;
  final String parentsName;
  final String parentsPhone;
  final String parentsEmail;

  const StudentCard({
    Key? key,
    required this.profile,
    required this.subject,
    required this.studentEmail,
    required this.medium,
    required this.parentsName,
    required this.parentsPhone,
    required this.parentsEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoText('Student Email', studentEmail),
                    _buildInfoText('Subject', subject),
                    _buildInfoText('Medium', medium),
                    _buildInfoText('Parent\'s Name', parentsName),
                    _buildInfoText('Parent\'s Phone', parentsPhone),
                    _buildInfoText('Parent\'s Email', parentsEmail),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Image.network(
                profile,
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/profile_avatar.png',
                      width: 80, height: 80);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.lora(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222831),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF180565),
                fontSize: 13,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

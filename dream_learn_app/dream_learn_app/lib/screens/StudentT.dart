import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentT extends StatelessWidget {
  const StudentT({Key? key}) : super(key: key);

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StudentCard(
          name: 'John Doe',
          medium: 'Sinhala',
          subject: 'Mathematics',
          StudentEmail: 'asd@dafa',
          parentsName: 'Jagath Nimal',
          parentsPhone: '0712345678',
          parentsEmail: 'jagath@example.com',
          profile: 'assets/profile_avatar.png',
        ),
        StudentCard(
          name: 'Jane Doe',
          medium: 'English',
          subject: 'English',
          StudentEmail: 'asd@dafa',
          parentsName: 'Samn Kumara',
          parentsPhone: '0712345678',
          parentsEmail: 'samn@example.com',
          profile: 'assets/profile_avatar.png',
        ),
        StudentCard(
          name: 'Jane Doe',
          medium: 'English',
          subject: 'English',
          StudentEmail: 'asd@dafa',
          parentsName: 'Samn Kumara',
          parentsPhone: '0712345678',
          parentsEmail: 'samn@example.com',
          profile: 'assets/profile_avatar.png',
        ),
        StudentCard(
          name: 'Jane Doe',
          medium: 'English',
          subject: 'English',
          StudentEmail: 'asd@dafa',
          parentsName: 'Samn Kumara',
          parentsPhone: '0712345678',
          parentsEmail: 'samn@example.com',
          profile: 'assets/profile_avatar.png',
        ),
        StudentCard(
          name: 'Jane Doe',
          medium: 'English',
          subject: 'English',
          StudentEmail: 'asd@dafa',
          parentsName: 'Samn Kumara',
          parentsPhone: '0712345678',
          parentsEmail: 'sadsds@dsds',
          profile: 'assets/profile_avatar.png',
        ),
      ],
    );
  }
}

class StudentCard extends StatelessWidget {
  final String profile;
  final String name;
  final String subject;
  final String StudentEmail;
  final String medium;
  final String parentsName;
  final String parentsPhone;
  final String parentsEmail;

  StudentCard({
    required this.profile,
    required this.name,
    required this.subject,
    required this.StudentEmail,
    required this.medium,
    required this.parentsName,
    required this.parentsPhone,
    required this.parentsEmail,
  });

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFF180565),
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildInfoText('StudentEmail', StudentEmail),
                  _buildInfoText('Subject', subject),
                  _buildInfoText('Medium', medium),
                  _buildInfoText('ParentsName', parentsName),
                  _buildInfoText('ParentsPhone', parentsPhone),
                  _buildInfoText('ParentsEmail', parentsEmail),
                ],
              ),
              SizedBox(width: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image(
                    image: AssetImage(profile),
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.lora(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222831),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFF180565),
            fontSize: 13,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}

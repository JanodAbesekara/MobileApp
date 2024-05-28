import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

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
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align children to the start of the column
      children: [
        StudentCard(
          name: 'John Doe',
          mediem: 'Shinhala',
          subject: 'Mathematics',
          parentsnamel: 'jagath nimal',
          parentspho: '0712345678',
          parentsEmail: 'dasdfafad@zfd',
        ),
        StudentCard(
          name: 'Jane Doe',
          mediem: 'English',
          subject: 'English',
          parentsnamel: 'samn kumara',
          parentspho: '0712345678',
          parentsEmail: 'dasdfafad@zfd',
        ),
      ],
    );
  }
}

class StudentCard extends StatelessWidget {
  final String name;
  final String mediem;
  final String subject;
  final String parentsnamel;
  final String parentspho;
  final String parentsEmail;

  const StudentCard({
    Key? key,
    required this.name,
    required this.mediem,
    required this.subject,
    required this.parentsnamel,
    required this.parentspho,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
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
                  SizedBox(height: 5),
                  Text(
                    subject,
                    style: TextStyle(
                      color: Color(0xFF180565),
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    mediem,
                    style: TextStyle(
                      color: Color(0xFF180565),
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    parentsnamel,
                    style: TextStyle(
                      color: Color(0xFF180565),
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    parentspho,
                    style: TextStyle(
                      color: Color(0xFF180565),
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    parentsEmail,
                    style: TextStyle(
                      color: Color(0xFF180565),
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0,top: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/profile_avatar.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

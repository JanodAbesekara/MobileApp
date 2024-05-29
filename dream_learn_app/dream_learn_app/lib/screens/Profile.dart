import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/AppInsideBackground.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundScreen(
            child: _buildProfile(),
          ),
          Positioned(
            top: 40,
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

  Widget _buildProfile() {
    return Column(
      children: [
        _buildAvatar(),
        _buildNameAndDate(),
        _buildContactInfo(),
      ],
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
      child: Image.asset(
        'assets/profile_avatar.png',
        width: 191,
        height: 189,
      ),
    );
  }

  Widget _buildNameAndDate() {
    return Column(
      children: [
        Text(
          'John Doe', // Replace with actual name

          style: GoogleFonts.roboto(
            color: Color(0xFF180565),
            fontSize: 20,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '2010.09.12', // Replace with actual date
          style: GoogleFonts.acme(
            color: Color.fromARGB(255, 152, 6, 231),
            fontSize: 12,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 40), // Added SizedBox here
      ],
    );
  }

  Widget _buildContactInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 20.0, 30.0, 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 223, 221, 231),
              ),
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(
                  131, 139, 137, 149), // Add background color to the container
            ),
            child: Column(
              children: [
                _buildContactRow(Icons.email, ':-  Twasda@gmail.com'),
                _buildContactRow(Icons.phone, ':-  0123456789'),
                _buildContactRow(Icons.location_on, ':-  Phnom Penh, Cambodia'),
                _buildContactRow(Icons.class_,
                    ':-  Math, Science, English'), // changed from 'classes' to 'class_'
              ],
            ),
          ),
          SizedBox(height: 60), // Added SizedBox here
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          30.0, 10.0, 40.0, 20.0), // Removed bottom padding here
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Color.fromARGB(255, 61, 60,
                  73), // Change text color to contrast with the container background color
              fontSize: 15,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (details) {
              if (details.localPosition.dx < 50 && details.localPosition.dy < 50) {
                Navigator.of(context).pop();
              }
            },
            child: BackgroundScreen(
              child: _profile(context),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: 80,
              height: 80,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: Colors.transparent, // Invisible area
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profile(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0), // Margin from top
            width: 100.0, // Width of the image container
            height: 100.0, // Height of the image container
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Circular shape
              border: Border.all(
                color: Colors.blue, // Border color
                width: 3.0, // Border width
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/profile_avatar.png', // Image asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          // User Name Text
          Text(
            'John Doe', // User's name
            style: TextStyle(
              fontSize: 20, // Font size
              fontWeight: FontWeight.bold, // Bold font weight
            ),
          ),
          // User's Date of Birth Text
          Text(
            '2024.2.12', // User's date of birth
            style: TextStyle(
              fontSize: 13, // Font size
              color: Colors.grey, // Text color
            ),
          ),
          SizedBox(height: 20),
          // Contact Information Container
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50), // Horizontal margin
            decoration: BoxDecoration(
              color: Colors.grey[300], // Background color
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.all(30.0), // Padding inside the container
              child: Column(
                children: [
                  // Phone Number Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Start alignment
                    children: [
                      Image.asset(
                        'assets/Tprofile/tel.png', // Phone icon asset path
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          ':- 012312321', // User's phone number
                          style: TextStyle(
                            fontSize: 15, // Font size
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Email Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Start alignment
                    children: [
                      Image.asset(
                        'assets/Tprofile/email.png', // Email icon asset path
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          ':- janod@gmail.com', // User's email
                          style: TextStyle(
                            fontSize: 15, // Font size
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Location Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Start alignment
                    children: [
                      Image.asset(
                        'assets/Tprofile/location.png', // Location icon asset path
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          ':- Penalikadawara, Moragene', // User's location
                          style: TextStyle(
                            fontSize: 15, // Font size
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Subjects Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Start alignment
                    children: [
                      Image.asset(
                        'assets/Tprofile/classes.png', // Subjects icon asset path
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          ':- Chemistry,  Physics,  Biology', // User's subjects
                          style: TextStyle(
                            fontSize: 15, // Font size
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

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
    return BackgroundScreen(
      child: _profile(context),
    );
  }

  Widget _profile(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50.0), // Add margin to the top
          width: 100.0, // Specify the width of the image
          height: 100.0, // Specify the height of the image
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Use BoxShape.circle for a circular border
            border: Border.all(
              color: Colors.blue, // Color of the border
              width: 3.0, // Width of the border
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/profile_avatar.png', // Replace with your image URL or asset path
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'John Doe', // Replace with the user's name
          style: TextStyle(
            fontSize: 20, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
        Text(
          '2024.2.12', // Replace with the user's date of birth
          style: TextStyle(
            fontSize: 13, // Font size
            color: Colors.grey, // Text color
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20), // Add margin to the container
          decoration: BoxDecoration(
            color: Colors.grey[300], // Background color of the container
            borderRadius: BorderRadius.circular(20), // Border radius
          ),
          child: Padding(
            padding: EdgeInsets.all(10), // Add padding to the container
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Tprofile/tel.png', // Replace with your icon asset path
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 10), // Add spacing between icon and text
                Image.asset(
                  'assets/Tprofile/email.png', // Replace with your icon asset path
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 10), // Add spacing between icon and text
                Text(
                  ':-' + ' janod@gmail.com', // Replace with the user's email
                  style: TextStyle(
                    fontSize: 15, // Font size
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

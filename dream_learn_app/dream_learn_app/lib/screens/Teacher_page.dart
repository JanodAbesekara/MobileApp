import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class TeacherDash extends StatefulWidget {
  const TeacherDash({Key? key}) : super(key: key);

  @override
  _TeacherDashState createState() => _TeacherDashState();
}

class _TeacherDashState extends State<TeacherDash> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _dashboard(context),
    );
  }

 Widget _dashboard(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Image.asset(
          "assets/teacherdash.png",
          width: 400,
          height: 300,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 241, 241),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person, 
                color: Colors.blue,
                size: 30,
              ),
            ],
          ),
        ), // Add comma here
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
}
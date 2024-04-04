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
          // Add your other widgets here
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

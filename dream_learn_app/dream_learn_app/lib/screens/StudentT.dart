import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class StudentT extends StatelessWidget {
  const StudentT({Key? key}) : super(key: key);

  static const _loginTextStyles = TextStyle(
    color: Color(0xff4E919A),
    fontSize: 20,
    letterSpacing: 10,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _passChild(context),
    );
  }

  Widget _passChild(BuildContext context) {
    return Column();
  }
}
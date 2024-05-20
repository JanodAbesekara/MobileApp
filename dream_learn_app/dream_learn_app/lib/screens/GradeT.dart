import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class GradeT extends StatelessWidget {
  const GradeT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _passChild(context),
    );
  }

  Widget _passChild(BuildContext context) {
    return Column(
      
    );
  }
}

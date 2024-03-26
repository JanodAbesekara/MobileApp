import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/utils/role_selection_button.dart';
import 'package:flutter/material.dart';

class MainHome2 extends StatelessWidget {
  const MainHome2({super.key});

  Widget _passChild() {
    return Column(
      children: [
        Image.asset(
          "assets/children.png",
          width: 191,
          height: 229,
        ),
        const SizedBox(height: 20),
        RoleSelectionButton("assets/student_icon.png", 'Students', () {}),
        const SizedBox(height: 20),
        RoleSelectionButton("assets/teacher_icon.png", 'Teachers', () {}),
        const SizedBox(height: 50),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _passChild(),
    );
  }
}

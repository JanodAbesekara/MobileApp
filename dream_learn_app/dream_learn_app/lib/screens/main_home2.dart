import 'package:dream_learn_app/screens/login_screen.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/registered_class_list.dart';
import 'package:dream_learn_app/screens/student_dashboard.dart';
import 'package:dream_learn_app/utils/role_selection_button.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/Teacher_page.dart';

class MainHome2 extends StatelessWidget {
  const MainHome2({super.key});

  Widget _passChild(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Image.asset(
            "assets/children.png",
            width: 191,
            height: 229,
          ),
          const SizedBox(height: 20),
          RoleSelectionButton("assets/student_icon.png", 'Students', () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisteredClassList()));
          }),
          const SizedBox(height: 20),
          RoleSelectionButton("assets/teacher_icon.png", 'Teachers', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TeacherDash()),
            );
          }),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      shouldShowSidebar: true,
      child: _passChild(context),
    );
  }
}

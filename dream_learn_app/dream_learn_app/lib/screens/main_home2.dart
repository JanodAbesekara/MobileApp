import 'package:dream_learn_app/screens/login_screen.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/registered_class_list.dart';
import 'package:dream_learn_app/screens/student_dashboard.dart';
import 'package:dream_learn_app/utils/role_selection_button.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/Teacher_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class MainHome2 extends StatelessWidget {
  const MainHome2({Key? key}) : super(key: key);

  static Future<String?> _getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    String? role = decodedToken['role'];
    return role;
  }

  Widget _passChild(BuildContext context, String role) {
    return GestureDetector(
      child: Column(
        children: [
          Image.asset(
            "assets/children.png",
            width: 191,
            height: 229,
          ),
          const SizedBox(height: 80),
          if (role == 'Student')
            RoleSelectionButton("assets/student_icon.png", 'Students', () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisteredClassList()));
            }),
          if (role == 'Lecturer')
            RoleSelectionButton("assets/teacher_icon.png", 'Teachers', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeacherDash()),
              );
            }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('Role not found'));
        } else {
          return BackgroundScreen(
            child: _passChild(context, snapshot.data!),
          );
        }
      },
    );
  }
}

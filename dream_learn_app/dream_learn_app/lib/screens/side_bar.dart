import 'package:dream_learn_app/screens/contact_us.dart';
import 'package:dream_learn_app/screens/login_screen.dart';
import 'package:dream_learn_app/utils/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/about_us.dart';
import 'package:dream_learn_app/screens/student_dashboard.dart';
import 'package:dream_learn_app/screens/web_view_screen.dart';
import 'package:dream_learn_app/screens/web_view_2.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dream_learn_app/screens/Teacher_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Image.asset(
                'assets/logo.png',
                height: 100, // Adjust height as needed
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  SettingsListTile(
                    imagePath: 'assets/about_us_icon.png',
                    title: 'About us',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const AboutUS()),
                      );
                    },
                  ),
                  const Divider(),
                  SettingsListTile(
                    imagePath: 'assets/contact_us_icon.png',
                    title: 'Contact us',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ContactUS()),
                      );
                    },
                  ),
                  const Divider(),
                  SettingsListTile(
                    imagePath: 'assets/find_teacher_icon.png',
                    title: 'Classes',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const WebViewScreen2()),
                      );
                    },
                  ),
                  const Divider(),
                  SettingsListTile(
                    imagePath: 'assets/backto_dashboard_icon.png',
                    title: 'Back to Dashboard',
                    onTap: () async {
                      String? role = await _getUserRole();
                      if (role == 'Student') {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => StudentDashboard()),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TeacherDash()),
                        );
                      }
                    },
                  ),
                  const Divider(),
                  SettingsListTile(
                    imagePath: 'assets/log_out_icon.png',
                    title: 'Log Out',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dream_learn_app/screens/contact_us.dart';
import 'package:dream_learn_app/utils/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsListTile(
                imagePath: 'assets/my_account_settings_icon.png',
                title: 'My Account',
                onTap: () {
                  print('go to my account');
                }),
            SettingsListTile(
                imagePath: 'assets/setting_icon.png',
                title: 'Settings',
                onTap: () {
                  print('go to settings');
                }),
            SettingsListTile(
              imagePath: 'assets/knowledge_base_icon.png',
              title: 'Knowledge base',
              onTap: () async {
                const url =
                    'https://byte-group-project.vercel.app/knowledgebase';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            SettingsListTile(
              imagePath: 'assets/about_us_icon.png',
              title: 'About us',
              onTap: () async {
                const url = 'https://byte-group-project.vercel.app/aboutus';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            SettingsListTile(
                imagePath: 'assets/contact_us_icon.png',
                title: 'Contact us',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ContactUS()));
                }),
            SettingsListTile(
                imagePath: 'assets/backto_dashboard_icon.png',
                title: 'Back to DashBord',
                onTap: () {
                  Navigator.of(context).pop();
                }),
            SettingsListTile(
              imagePath: 'assets/find_teacher_icon.png',
              title: 'Finding Teachers',
              onTap: () async {
                const url = 'https://byte-group-project.vercel.app/aboutus';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            SettingsListTile(
                imagePath: 'assets/log_out_icon.png',
                title: 'Log Out',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
      ),
    );
  }
}

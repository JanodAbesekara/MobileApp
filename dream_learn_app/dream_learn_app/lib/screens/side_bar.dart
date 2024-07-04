import 'package:dream_learn_app/screens/contact_us.dart';
import 'package:dream_learn_app/screens/login_screen.dart';
import 'package:dream_learn_app/utils/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/about_us.dart';


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
                onTap: () {
                  print('go to settings');
                }),
            SettingsListTile(
                imagePath: 'assets/about_us_icon.png',
                title: 'About us',
                onTap: () {
                  //print('go to settings');
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const  AboutUS()));
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUS()));

                }),
            SettingsListTile(
                imagePath: 'assets/contact_us_icon.png',
                title: 'Contact us',
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContactUS()));
                }),
            SettingsListTile(
                imagePath: 'assets/backto_dashboard_icon.png',
                title: 'Back to DashBord',
                onTap: () {
                  print('go to settings');
                }),
            SettingsListTile(
                imagePath: 'assets/find_teacher_icon.png',
                title: 'Finding Teachers',
                onTap: () {
                  print('go to settings');
                }),
            SettingsListTile(
                imagePath: 'assets/log_out_icon.png',
                title: 'Log Out',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>   LoginScreen()));
                 
                }),
          ],
        ),
      ),
    );
  }
}

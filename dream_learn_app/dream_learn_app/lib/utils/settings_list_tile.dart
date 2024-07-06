import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final void Function() onTap;

  const SettingsListTile({required this.imagePath, required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SizedBox(width: 40, height: 40, child: Image.asset(imagePath)),
      title: Text(title),
    );
  }
}
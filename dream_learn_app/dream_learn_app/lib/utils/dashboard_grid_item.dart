import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardGridItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final void Function() onTap;
  final Color backgroundColor; // Add backgroundColor parameter

  const DashboardGridItem({
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.backgroundColor = const Color(0xFFD9EAFD), // Default to light blue
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: backgroundColor, // Set background color
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
          ),
        ),
        // Text
        Text(title),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class RoleSelectionButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final void Function() onPressed;
  const RoleSelectionButton(this.imagePath, this.title, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 332,
      height: 61,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // <-- Radius
          ),
        ),
        child: Row(children: [
          Image.asset(
            imagePath,
            width: 47,
            height: 50,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 24, color: Colors.grey, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}

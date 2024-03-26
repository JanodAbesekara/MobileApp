import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  const CommonTextField({required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade200,
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(),
            border: InputBorder.none,
          ),
        ));
  }
}

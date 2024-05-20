import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscureText;
  const CommonTextField({required this.hintText,required this.controller,this.isObscureText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade200,
        child: TextFormField(
          obscureText: isObscureText ?? false,
          controller:controller ,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(),
            border: InputBorder.none,
          ),
        ));
  }
}

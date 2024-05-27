import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/utils/class_card.dart';
import 'package:flutter/material.dart';

class RegisteredClassList extends StatelessWidget {
  const RegisteredClassList({super.key});


  
  Widget _passChild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //class cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: ClassCard(title: 'Physics',dateTime: '26 September 2024, 3:15 PM',timeLimit: 'Time limit: 30 mins',),
        ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: ClassCard(title: 'Chemistry',dateTime: '26 September 2024, 3:15 PM',timeLimit: 'Time limit: 30 mins',),
        ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: ClassCard(title: 'Biology',dateTime: '26 September 2024, 3:15 PM',timeLimit: 'Time limit: 30 mins',),
        ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: ClassCard(title: 'English',dateTime: '26 September 2024, 3:15 PM',timeLimit: 'Time limit: 30 mins',),
        ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: ClassCard(title: 'GIT',dateTime: '26 September 2024, 3:15 PM',timeLimit: 'Time limit: 30 mins',),
        ),
   
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _passChild(context),
    );
  }
}
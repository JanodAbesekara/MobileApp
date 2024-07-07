import 'package:flutter/material.dart';

class GradeCard extends StatelessWidget {
  final String subject;
  final int score;
  final String grade;
  final String medium;
  const GradeCard({required this.subject,required this.score,required this.grade,required this.medium, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      height: 102,
     
      decoration: BoxDecoration(
         color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        //title
        Text("Subject : $subject",style: const TextStyle(
          fontSize: 20
        ),),
            Text("Medium : $medium",style: const TextStyle(
          fontSize: 10
        )),
  
         Text("Grade : $grade",style: const TextStyle(
          fontSize: 10
        )),
         Text("Score : $score".toString(),style: const TextStyle(
          fontSize: 10
        ),),
        
       ],
      ),
    
    ); }
}
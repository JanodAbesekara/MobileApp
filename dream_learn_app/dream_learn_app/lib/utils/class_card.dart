import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget {
  final String title;
  final String medium;
  final String dateTime;
  const ClassCard({required this.title,required this.dateTime,required this.medium, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      height: 102,
     
      decoration: BoxDecoration(
         color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        //title
        Text(title,style: TextStyle(
          fontSize: 20
        ),),
        SizedBox(height: 20,),
         Text(medium,style: TextStyle(
          fontSize: 10
        )),
         Text(dateTime,style: TextStyle(
          fontSize: 10
        ),),
        
       ],
      ),
    
    ); }
}
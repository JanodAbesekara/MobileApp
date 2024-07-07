import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardGridItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final void Function() onTap;
  const DashboardGridItem({required this.iconPath,required this.title,required this.onTap ,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //icon
       GestureDetector(
        onTap: () {
          onTap();
        },
         child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
             border: Border.all()
          ),
          child: Image.asset(iconPath,width: 30,height: 30,)),
       ),

        //text
        Text(title)
      ],
    );
  }
}
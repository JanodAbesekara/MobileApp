import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/side_bar.dart';
import 'package:dream_learn_app/utils/dashboard_grid_item.dart';
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {

  const StudentDashboard({super.key});

 static List<Map<String,dynamic>> _gridItemList=[{
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Tution fees',
    'onTap':(){
      print('first item clicked');
    }
  },{
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Teachers',
     'onTap':(){
      print('second item clicked');
    }
  },
  {
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Home work',
     'onTap':(){
      print('third item clicked');
    }
  },
  {
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Assingmnets',
     'onTap':(){
      print('fourth item clicked');
    }
  },
  {
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Learning materials',
     'onTap':(){
      print('fifth item clicked');
    }
  },
  {
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Feedbacks',
     'onTap':(){
      print('sixth item clicked');
    }
  },
  {
    'iconPath':'assets/find_teacher_icon.png',
    'title':' Announcement',
     'onTap':(){
      print('seventh item clicked');
    }
  },
  {
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Quizzes',
     'onTap':(){
      print('8th item clicked');
    }
  },{
    'iconPath':'assets/find_teacher_icon.png',
    'title':'Grades',
     'onTap':(){
      print('9th item clicked');
    }
  }
  ];

  Widget  _passChild(BuildContext context){

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [Container(
          decoration: BoxDecoration(
            color: Color(0xffD9D9D9).withOpacity(0.9),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
            Image.asset('assets/student_dashboard_main_icon.png',height: 170,),
            const SizedBox(
              height: 20,
            ),
           GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio:1.4,
            children: _gridItemList.map((map) =>  DashboardGridItem(iconPath: map['iconPath'],title: map['title'],onTap:map['onTap'],)).toList(),
           ),
          
             
          
            ],
          ),
        ),
        const SizedBox(height: 10,),
        IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SideBar()));
        }, icon: Icon(Icons.menu,color: Colors.blue,))
        ]
      ),
    );
    
  }


  @override
  Widget build(BuildContext context) {
    return  BackgroundScreen(child: _passChild(context));
  }
}



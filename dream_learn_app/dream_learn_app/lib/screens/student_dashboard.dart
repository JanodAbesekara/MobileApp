import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/learning_material_screen.dart';
import 'package:dream_learn_app/screens/side_bar.dart';
import 'package:dream_learn_app/screens/student_payments.dart';
import 'package:dream_learn_app/screens/student_quiz_screen.dart';
import 'package:dream_learn_app/screens/teacher_details.dart';
import 'package:dream_learn_app/utils/dashboard_grid_item.dart';
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  final String? teacherEmail;
  final String? subject;
  final String? medium;

  const StudentDashboard({super.key, this.teacherEmail, this.subject,this.medium});

  Widget _passChild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xffD9D9D9).withOpacity(0.9),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/student_dashboard_main_icon.png',
                height: 170,
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.4,
                // children: _gridItemList.map((map) =>  DashboardGridItem(iconPath: map['iconPath'],title: map['title'],onTap:map['onTap'],)).toList(),
                children: [
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Tution fees',
                    
                    onTap: () =>Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>   StudentTutionFees(
                          teacherEmail:teacherEmail ?? '' ,subject:subject ?? '' ,medium:medium ?? '' ,
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Teacher',
                    onTap: () =>Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  TeacherDetails(
                           teacherEmail: teacherEmail ?? '',
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Home work',
                    onTap: () {},
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Assingmnets',
                    onTap: () {},
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Learning materials',
                    onTap:()=>  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LearningMaterialsScreen(
                            teacherEmail:teacherEmail ?? '' ,subject:subject ?? '' ,medium:medium ?? '' ,
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Feedbacks',
                    onTap: () {},
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Announcement',
                    onTap: () {},
                  ),
                  DashboardGridItem(
                      iconPath: 'assets/find_teacher_icon.png',
                      title: 'Quizzes',
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentQuizScreen(
                              teacherEmail: teacherEmail, subject: subject,medium: medium,)))),
                  DashboardGridItem(
                    iconPath: 'assets/find_teacher_icon.png',
                    title: 'Grades',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
     
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      shouldShowSidebar: true,
      child: _passChild(context));
  }
}

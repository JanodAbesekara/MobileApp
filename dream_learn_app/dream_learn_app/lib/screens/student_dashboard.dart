import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/feedbackscreen.dart';
import 'package:dream_learn_app/screens/learning_material_screen.dart';
import 'package:dream_learn_app/screens/side_bar.dart';
import 'package:dream_learn_app/screens/student_announcments.dart';
import 'package:dream_learn_app/screens/student_assignments.dart';
import 'package:dream_learn_app/screens/student_payments.dart';
import 'package:dream_learn_app/screens/student_quiz_screen.dart';
import 'package:dream_learn_app/screens/teacher_details.dart';
import 'package:dream_learn_app/screens/web_view_screen.dart';
import 'package:dream_learn_app/utils/dashboard_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/student_grades.dart';

class StudentDashboard extends StatelessWidget {
  final String? teacherEmail;
  final String? subject;
  final String? medium;

  const StudentDashboard({super.key, this.teacherEmail, this.subject,this.medium});


  Widget _passChild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/student_dashboard_main_icon.png',
              height: 170,
            ),
            const SizedBox(
              height: 20,
            ),
         
            Container(
                  decoration: BoxDecoration(
              color: const Color(0xffD9D9D9).withOpacity(0.9),
              borderRadius: BorderRadius.circular(20)),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.4,
                // children: _gridItemList.map((map) =>  DashboardGridItem(iconPath: map['iconPath'],title: map['title'],onTap:map['onTap'],)).toList(),
                children: [
                  DashboardGridItem(
                    iconPath: 'assets/tuitionfees.png',
                    title: 'Tution fees',
                    
                    onTap: () =>Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>   StudentTutionFees(
                          teacherEmail:teacherEmail ?? '' ,subject:subject ?? '' ,medium:medium ?? '' ,
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/teacher.png',
                    title: 'Teacher',
                    onTap: () =>Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  TeacherDetails(
                           teacherEmail: teacherEmail ?? '',
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/edubase.png',
                    title: 'Knowledge Home',
                    
                    onTap: ()=>  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WebViewScreen(
                            
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/assignment.png',
                    title: 'Assingmnets',
                    
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  StudentAssignmentScreen(
                             teacherEmail: teacherEmail, subject: subject,medium: medium,
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/Lecture_meterials.png',
                    title: 'Learning materials',
                    onTap:()=>  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LearningMaterialsScreen(
                            teacherEmail:teacherEmail ?? '' ,subject:subject ?? '' ,medium:medium ?? '' ,
                              ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/feedbacks.png',
                    title: 'Feedbacks',
                    
                    onTap: ()=>  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  FeedbackScaren(
                            
                              )))
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/annoucement.png',
                    title: 'Announcement',
                    
                    onTap: () =>Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentAnnouncement(
                            teacherEmail:teacherEmail ?? '' ,subject:subject ?? '' ,medium:medium ?? '' ,
                              ))),
                  ),
                  DashboardGridItem(
                      iconPath: 'assets/quizzes.png',
                      title: 'Quizzes',
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentQuizScreen(
                              teacherEmail: teacherEmail, subject: subject,medium: medium,)))),
                  DashboardGridItem(
                    iconPath: 'assets/grades.png',
                    title: 'Grades',
                    onTap: ()=>  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  StudentGrades(
                           teacherEmail: teacherEmail ?? '',
                          
                            
                              ))),
                  ),
                ],
              ),
            ),
          ],
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

import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/feedbackscreen.dart';
import 'package:dream_learn_app/screens/learning_material_screen.dart';
import 'package:dream_learn_app/screens/side_bar.dart';
import 'package:dream_learn_app/screens/student_announcments.dart';
import 'package:dream_learn_app/screens/student_payments.dart';
import 'package:dream_learn_app/screens/student_quiz_screen.dart';
import 'package:dream_learn_app/screens/teacher_details.dart';
import 'package:dream_learn_app/screens/web_viewers/knowladge_base_by_web.dart';
import 'package:dream_learn_app/utils/dashboard_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/student_grades.dart';
import 'package:dream_learn_app/screens/web_viewers/assignments_by_web.dart';

class StudentDashboard extends StatelessWidget {
  final String? teacherEmail;
  final String? subject;
  final String? medium;

  const StudentDashboard({super.key, this.teacherEmail, this.subject, this.medium});

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
                children: [
                  DashboardGridItem(
                    iconPath: 'assets/tuitionfees.png',
                    title: 'Tution fees',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentTutionFees(
                              teacherEmail: teacherEmail ?? '',
                              subject: subject ?? '',
                              medium: medium ?? '', 
                            ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/teacher.png',
                    title: 'Teacher',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TeacherDetails(
                              teacherEmail: teacherEmail ?? '',
                              subject: subject ?? '',
                              medium: medium ?? '',
                            ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/edubase.png',
                    title: 'Knowledge Home',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const KnowladgeBaseByWeb())),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/assignment.png',
                    title: 'Assingmnets',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AssignmentsbyWeb())),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/Lecture_meterials.png',
                    title: 'Learning materials',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LearningMaterialsScreen(
                              teacherEmail: teacherEmail ?? '',
                              subject: subject ?? '',
                              medium: medium ?? '',
                            ))),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/feedbacks.png',
                    title: 'Feedbacks',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FeedbackScaren())),
                  ),
                  DashboardGridItem(
                    iconPath: 'assets/annoucement.png',
                    title: 'Announcement',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentAnnouncement(
                              teacherEmail: teacherEmail ?? '',
                              subject: subject ?? '',
                              medium: medium ?? '',
                            ))),
                  ),
                  DashboardGridItem(
                      iconPath: 'assets/quizzes.png',
                      title: 'Quizzes',
                      backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentQuizScreen(
                                teacherEmail: teacherEmail,
                                subject: subject,
                                medium: medium,
                              )))),
                  DashboardGridItem(
                    iconPath: 'assets/grades.png',
                    title: 'Grades',
                    backgroundColor: Colors.lightBlue[50]!, // Set light blue color
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentGrades(
                              teacherEmail: teacherEmail ?? '',
                              subject: subject,
                              medium: medium,
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



// import 'package:dream_learn_app/screens/background.dart';
// import 'package:dream_learn_app/screens/feedbackscreen.dart';
// import 'package:dream_learn_app/screens/learning_material_screen.dart';
// import 'package:dream_learn_app/screens/side_bar.dart';
// import 'package:dream_learn_app/screens/student_announcments.dart';
// import 'package:dream_learn_app/screens/student_payments.dart';
// import 'package:dream_learn_app/screens/student_quiz_screen.dart';
// import 'package:dream_learn_app/screens/teacher_details.dart';
// import 'package:dream_learn_app/screens/web_viewers/knowladge_base_by_web.dart';
// import 'package:dream_learn_app/utils/dashboard_grid_item.dart';
// import 'package:flutter/material.dart';
// import 'package:dream_learn_app/screens/student_grades.dart';
// import 'package:dream_learn_app/screens/web_viewers/assignments_by_web.dart';
// import 'package:dream_learn_app/models/student_class_fee.dart';

// class StudentDashboard extends StatelessWidget {
//   final String? teacherEmail;
//   final String? subject;
//   final String? medium;


//   const StudentDashboard({super.key, this.teacherEmail, this.subject, this.medium});

//   Widget _passChild(BuildContext context) {
//     // Create a StudentClassFee object with appropriate values
//     StudentClassFee studentClassFee = StudentClassFee.fromJson({
//       'payment': {
//         'TeacherEmail': teacherEmail ?? '',
//         'bank': 'bnkname ', // Replace with actual bank name
//         'accountNo': 'acccount',// Replace with actual account number
//       },
      
//       'classpees': 'Your Class Fee', // Replace with actual class fee
//       'subject': subject ?? '',
//       'medium': medium ?? '',
      
//     });
//     return Padding(
      
//       padding: const EdgeInsets.all(15.0),
//       child: Column(children: [
//         Column(
//           children: [
//             const SizedBox(height: 20),
//             Image.asset(
//               'assets/student_dashboard_main_icon.png',
//               height: 170,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: const Color(0xffD9D9D9).withOpacity(0.9),
//                   borderRadius: BorderRadius.circular(20)),
//               child: GridView.count(
//                 shrinkWrap: true,
//                 crossAxisCount: 3,
//                 childAspectRatio: 1.4,
//                 children: [
//                   DashboardGridItem(
//                     iconPath: 'assets/tuitionfees.png',
//                     title: 'Tution fees',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => StudentTutionFees(
//                               teacherEmail: teacherEmail ?? '',
//                               subject: subject ?? '',
//                               medium: medium ?? '',
//                               // regdetal: studentClassFee, // Pass the StudentClassFee object
//                             ))),
//                   ),
//                   DashboardGridItem(
//                     iconPath: 'assets/teacher.png',
//                     title: 'Teacher',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => TeacherDetails(
//                               teacherEmail: teacherEmail ?? '',
//                               subject: subject ?? '',
//                               medium: medium ?? '',
//                             ))),
//                   ),
//                   DashboardGridItem(
//                     iconPath: 'assets/edubase.png',
//                     title: 'Knowledge Home',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const KnowladgeBaseByWeb())),
//                   ),
//                   DashboardGridItem(
//                     iconPath: 'assets/assignment.png',
//                     title: 'Assingmnets',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const AssignmentsbyWeb())),
//                   ),
//                   DashboardGridItem(
//                     iconPath: 'assets/Lecture_meterials.png',
//                     title: 'Learning materials',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => LearningMaterialsScreen(
//                               teacherEmail: teacherEmail ?? '',
//                               subject: subject ?? '',
//                               medium: medium ?? '',
//                             ))),
//                   ),
//                   DashboardGridItem(
//                     iconPath: 'assets/feedbacks.png',
//                     title: 'Feedbacks',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => FeedbackScaren())),
//                   ),
//                   DashboardGridItem(
//                     iconPath: 'assets/annoucement.png',
//                     title: 'Announcement',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => StudentAnnouncement(
//                               teacherEmail: teacherEmail ?? '',
//                               subject: subject ?? '',
//                               medium: medium ?? '',
//                             ))),
//                   ),
//                   DashboardGridItem(
//                       iconPath: 'assets/quizzes.png',
//                       title: 'Quizzes',
//                       backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                       onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => StudentQuizScreen(
//                                 teacherEmail: teacherEmail,
//                                 subject: subject,
//                                 medium: medium,
//                               )))),
//                   DashboardGridItem(
//                     iconPath: 'assets/grades.png',
//                     title: 'Grades',
//                     backgroundColor: Colors.lightBlue[50]!, // Set light blue color
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => StudentGrades(
//                               teacherEmail: teacherEmail ?? '',
//                               subject: subject ?? '',
//                               medium: medium ?? '',
//                             ))),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//       ]),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BackgroundScreen(
//         shouldShowSidebar: true,
//         child: _passChild(context));
//   }
// }

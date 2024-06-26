import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/Profile.dart';
import 'package:dream_learn_app/screens/announcement.dart';
import 'package:dream_learn_app/screens/attendenceT.dart';
import 'package:dream_learn_app/screens/lecturematerial.dart';
import 'package:dream_learn_app/screens/StudentT.dart';
import 'package:dream_learn_app/screens/TAssignment.dart';
import 'package:dream_learn_app/screens/GradeT.dart';
import 'package:dream_learn_app/screens/QuizessT.dart';
import 'package:dream_learn_app/screens/Feedbacksview.dart';
import 'package:url_launcher/url_launcher.dart';




class TeacherDash extends StatefulWidget {
  const TeacherDash({Key? key}) : super(key: key);

  @override
  _TeacherDashState createState() => _TeacherDashState();
}

class _TeacherDashState extends State<TeacherDash> {
  final List<String> sampleImages = [
    "assets/T/profile.png",
    "assets/T/announce1.png",
    "assets/T/attendence12.png",
    "assets/T/lecmaterial.png",
    "assets/T/Stu12.png",
    "assets/T/TAss.png",
    "assets/T/gade12.png",
    "assets/T/test.png",
    "assets/T/feed12.png",
  ];

  final List<String> sampleNames = [
    "Profile",
    "Announcement",
    "Attendance",
    "Materials",
    "Students",
    "Assignments",
    "Grades",
    "Quizzes",
    "Feedbacks",
  ];

  final List<Widget> samplePages = [
   const Profile(),
   const Announcement(),
   const AttendenceT(),
   const LectureMaterial(),
   const StudentT(),
   const TAssignment(),
   const GradeT(),
   const QuizessT(),
   const Feedbacksview(),
  ];

  final double desiredWidth = 30.0; // Adjust according to your requirement
  final double desiredHeight = 30.0; // Adjust according to your requirement

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _dashboard(context),
    );
  }

  Widget _dashboard(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const SizedBox(
            height: 0.0,
          ),
          Image.asset(
            "assets/teacherdash.png",
            width: 400,
            height: 300,
          ),
         const SizedBox(
            height: 0.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46.0), // Add padding to left and right
            child: Container(
              color: Colors.grey[300], // Set your desired background color here
              child: GridView.builder(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 columns
                  crossAxisSpacing: 10.0, // horizontal space between each item
                  mainAxisExtent: 80.0, // vertical space between each item
                ),
                itemCount: sampleImages.length, // Number of sample images
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => samplePages[index],
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          margin:const EdgeInsets.all(10.0),
                          padding:const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color:const Color.fromARGB(255, 245, 241, 241),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(
                            sampleImages[index],
                            width: desiredWidth,
                            height: desiredHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                       const SizedBox(height: 1.0), // Space between image and text
                        Text(
                          sampleNames[index], // Use sampleNames list to display image names
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
         const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}



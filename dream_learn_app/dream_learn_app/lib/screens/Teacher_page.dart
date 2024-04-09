import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class TeacherDash extends StatefulWidget {
  const TeacherDash({Key? key}) : super(key: key);

  @override
  _TeacherDashState createState() => _TeacherDashState();
}

class _TeacherDashState extends State<TeacherDash> {
  final List<String> sampleImages = [
    "assets/T/TAss.png",
    "assets/T/Quises.png",
    "assets/T/Tann.png",
    "assets/T/Tattendence.png",
    "assets/T/Tprofile.png",
    "assets/T/TLerning.png",
    "assets/T/TStudent.png",
    "assets/T/Tgades.png",
    "assets/T/Tfeed.png",
  ];

  final List<String> sampleNames = [
    "TAss",
    "Quises",
    "Tann",
    "Tattendence",
    "Tprofile",
    "TLerning",
    "TStudent",
    "Tgades",
    "Tfeed",
  ];

  final double desiredWidth = 40.0; // Adjust according to your requirement
  final double desiredHeight = 40.0; // Adjust according to your requirement

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
          SizedBox(
            height: 2,
          ),
          Image.asset(
            "assets/teacherdash.png",
            width: 400,
            height: 300,
          ),
          SizedBox(
            height: 2,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns
              crossAxisSpacing: 40.0, // horizontal space between each item
              mainAxisExtent: 80.0, // vertical space between each item
            ),
            itemCount: sampleImages.length, // Number of sample images
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      sampleImages[index],
                      width: desiredWidth,
                      height: desiredHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 2), // Space between image and text
                  Text(
                    sampleNames[index], // Use sampleNames list to display image names
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 0,
          ),
        ],
      ),
    );
  }
}

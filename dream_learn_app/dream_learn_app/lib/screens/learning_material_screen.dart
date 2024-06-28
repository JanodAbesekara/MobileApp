import 'package:dream_learn_app/models/lecture_material.dart';
import 'package:dream_learn_app/screens/lecturematerial.dart'
    hide LectureMaterial;
import 'package:dream_learn_app/screens/pdf_view.dart';
import 'package:dream_learn_app/screens/video_view.dart';
import 'package:dream_learn_app/services/lecture_material_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LearningMaterialsScreen extends StatefulWidget {
  final String teacherEmail;
  final String subject;
  final String medium;

  const LearningMaterialsScreen(
      {required this.teacherEmail,
      required this.subject,
      required this.medium,
      super.key});

  @override
  State<LearningMaterialsScreen> createState() =>
      _LearningMaterialsScreenState();
}

class _LearningMaterialsScreenState extends State<LearningMaterialsScreen> {

  @override
  void initState() {
   
    super.initState();
  }

  Future<List<LectureMaterial>> _getLectureMaterials() async {
    final response = await LectureMaterialService.getLectureMaterials(
        widget.teacherEmail, widget.subject, widget.medium);
    return response;
  }

  _openZoomApp(Uri? zoomLink) async {
    if (zoomLink != null) {
      try {
        if (await canLaunchUrl(zoomLink)) {
          await launchUrl(zoomLink);
        } else {
          throw 'Could not launch $zoomLink';
        }
      } catch (err) {
        print('cannot open zoom link');
      }
    }
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Materials'),
      ),
      body: FutureBuilder<List<LectureMaterial>>(
          future: _getLectureMaterials(),
          builder: (context, snapshot) {
            if ((snapshot.data?.isEmpty ?? false)) {
              return const Center(
                child: Text('No lecture materials available'),
              );
            }
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: snapshot.data!
                    .map((lecMaterial) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //title
                              Text(
                                lecMaterial.lessonName.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //lecture note pdf
                              GestureDetector(
                                onTap: () =>Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnlinePdfView(pdfLink: lecMaterial.pdfPath.toString(),)),
            ),
                                child: Row(
                                  children: [
                                    //icon
                                    Image.asset(
                                      "assets/pdf.png",
                                      width: 32,
                                      height: 32,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    //text
                                    const Text('Lecture Note')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => _openZoomApp(lecMaterial.zoomLink),
                                child: Row(
                                  children: [
                                    //icon
                                    Image.asset(
                                      "assets/zoom.png",
                                      width: 32,
                                      height: 32,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    //text
                                    const Text('Zoom link')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                               onTap: () =>Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnlineVideoView(videoLink: lecMaterial.lectureRecording.toString(),)),
            ),
                                child: Row(
                                  children: [
                                    //icon
                                    Image.asset(
                                      "assets/lec_recording.png",
                                      width: 32,
                                      height: 32,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    //text
                                    const Text('Lecture Recording')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  //icon
                                  Image.asset(
                                    "assets/submission_link.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  //text
                                  const Text('Activity Submission Link')
                                ],
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              );
            }

            if (snapshot.hasError) {
              print('having issues loading lec materials');
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

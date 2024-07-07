import 'dart:developer';

import 'package:dream_learn_app/helpers/student_helper.dart';
import 'package:dream_learn_app/models/subject.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/screens/student_dashboard.dart';
import 'package:dream_learn_app/services/enrollment_service.dart';
import 'package:dream_learn_app/utils/class_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisteredClassList extends StatefulWidget {
  const RegisteredClassList({super.key});

  @override
  State<RegisteredClassList> createState() => _RegisteredClassListState();
}

class _RegisteredClassListState extends State<RegisteredClassList> {

  Future<List<Subject>> _getSubjectList()async{
    List<Subject>  subjectList = await EnrollmentService.getSubjectList();
    final filteredList = subjectList.where((sub) => sub.email == studentEmail).toList();
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: FutureBuilder(
        future: _getSubjectList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: snapshot.data!.map((subject) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to student dashboard
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StudentDashboard(
                        teacherEmail: subject.teacherEmail,
                        subject: subject.subjectName,
                        medium: subject.medium,
                      ),
                    ));
                  },
                  child: ClassCard(
                    title: subject.subjectName ?? '',
                    dateTime: DateFormat('d MMMM yyyy, h:mm a').format(subject.date ?? DateTime.now()),
                    medium: subject.medium ?? '',
                  ),
                ),
              )).toList(),
            );
          }

          if (snapshot.hasError) {
            print('Error loading subject list');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

import 'dart:ffi';
import 'dart:io';

import 'package:dream_learn_app/helpers/student_helper.dart';
import 'package:dream_learn_app/models/student_class_fee.dart';
import 'package:dream_learn_app/services/student_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class StudentTutionFees extends StatefulWidget {
  final String? teacherEmail;
  final String? subject;
  final String? medium;

  const StudentTutionFees(
      {required this.teacherEmail, required this.subject, required this.medium, super.key});

  @override
  State<StudentTutionFees> createState() => _StudentTutionFeesState();
}

class _StudentTutionFeesState extends State<StudentTutionFees> {
  bool _isLoading = false;

  Future<StudentClassFee> _getClassFeeDetails() async {
    StudentClassFee? filteredFee;
    List<StudentClassFee> feeList = await StudentService.getPayments(studentEmail);
    try {
      filteredFee = feeList.firstWhere((quz) =>
          quz.teacherEmail == widget.teacherEmail &&
          quz.subject == widget.subject &&
          quz.medium == widget.medium);
    } catch (err) {
      // Handle error
      rethrow;
    }

    return filteredFee;
  }

  Future _onFileSelection(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _isLoading = true;
      });

      try {
        FirebaseStorage storage = FirebaseStorage.instance;

        // Create a reference to the location you want to upload to in firebase
        Reference reference = storage.ref().child("/Recite/${basename(file.path)}");

        // Upload the file to firebase
        UploadTask uploadTask = reference.putFile(file);

        // Waits till the file is uploaded then stores the download url
        String uploadedLocation = await uploadTask.snapshot.ref.getDownloadURL();
        print('$uploadedLocation<------------------location is');
        setState(() {
          _isLoading = false;
        });
        var snackBar = const SnackBar(
          content: Align(
            alignment: Alignment.center,
            child: Text('Recipt uploaded successfully!'),
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (err) {
        // handle upload error
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Materials'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<StudentClassFee>(
          future: _getClassFeeDetails(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data...'),
              );
            }

            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Teacher email: ', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black87)),
                        Text('${snapshot.data!.teacherEmail}', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 10),
                        Text('Bank Name: ', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black87)),
                        Text('${snapshot.data!.bankName}', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 10),
                        Text('Account no: ', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black87)),
                        Text('${snapshot.data!.accountNo}', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 10),
                        Text('Class fee: Rs. ', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black87)),
                        Text('${snapshot.data!.classFee}', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async => await _onFileSelection(context),
                              child: const Text('Upload Recipts'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              ),
                            ),
                            if (_isLoading) const CircularProgressIndicator(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

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
      {required this.teacherEmail,
      required this.subject,
      required this.medium,
      super.key});

  @override
  State<StudentTutionFees> createState() => _StudentTutionFeesState();
}

class _StudentTutionFeesState extends State<StudentTutionFees> {
  bool _isLoading = false;

  Future<StudentClassFee> _getClassFeeDetails() async {
    StudentClassFee? filteredFee;
    List<StudentClassFee> feeList = await StudentService.getPayments();
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

  Future<void> _onFileSelection(
      BuildContext context, StudentClassFee feeDetails) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _isLoading = true;
      });

      try {
        FirebaseStorage storage = FirebaseStorage.instance;

        // Create a reference to the location you want to upload to in firebase
        Reference reference =
            storage.ref().child("/Recite/${basename(file.path)}");

        // Upload the file to firebase
        UploadTask uploadTask = reference.putFile(file);

        // Waits till the file is uploaded then stores the download url
        String uploadedLocation =
            await uploadTask.snapshot.ref.getDownloadURL();
        print('$uploadedLocation<------------------location is');

        // Post the payment details
        bool isPosted = await StudentService.postPayment(
          photoUrl: uploadedLocation,
          teacherEmail: feeDetails.teacherEmail!,
          subject: feeDetails.subject!,
          medium: feeDetails.medium!,
          bankName: feeDetails.bankName!,
          accountNo: feeDetails.accountNo!,
          // email: feeDetails.email, // You may need to pass the student's email if available
        );

        setState(() {
          _isLoading = false;
        });

        var snackBar = SnackBar(
          content: Align(
            alignment: Alignment.center,
            child: Text(
              isPosted
                  ? 'Receipt uploaded and payment posted successfully!'
                  : 'Receipt uploaded but payment failed!',
            ),
          ),
          backgroundColor: isPosted ? Color.fromARGB(255, 0, 0, 0) : Colors.red,
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (err) {
        // handle upload error
        setState(() {
          _isLoading = false;
        });

        var snackBar = const SnackBar(
          content: Align(
            alignment: Alignment.center,
            child: Text('Failed to upload receipt.'),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tution Fees'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<StudentClassFee>(
          future: _getClassFeeDetails(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data...'),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No data found...'),
              );
            } else {
              var feeDetails = snapshot.data!;
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
                        Text('Teacher email: ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black87)),
                        Text('${feeDetails.teacherEmail}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 10),
                        Text('Bank Name: ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black87)),
                        Text('${feeDetails.bankName}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 10),
                        Text('Account no: ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black87)),
                        Text('${feeDetails.accountNo}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 10),
                        Text('Class fee: Rs. ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black87)),
                        Text('${feeDetails.classFee}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async =>
                                  await _onFileSelection(context, feeDetails),
                              child: const Text('Upload Recipts'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12),
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
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}


//--------------------------------------------------- 


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:dream_learn_app/models/student_class_fee.dart';
// import 'package:dream_learn_app/services/student_service.dart';

// class StudentTutionFees extends StatefulWidget {
//   final String teacherEmail;
//   final String subject;
//   final String medium;
//   // final String regdetal;

//   const StudentTutionFees({
//     Key? key,
//     required this.teacherEmail,
//     required this.subject,
//     required this.medium,
//   //  required this.regdetal,
//   }) : super(key: key);

//   @override
//   _StudentTutionFeesState createState() => _StudentTutionFeesState();
// }

// class _StudentTutionFeesState extends State<StudentTutionFees> {
//   File? _receiptFile;
//   bool _isUploading = false;
//   double _uploadProgress = 0.0;
//   StudentClassFee? _paymentDetails;

//   @override
//   void initState() {
//     super.initState();
//     _fetchPaymentDetails();
//   }

//   Future<void> _fetchPaymentDetails() async {
//     try {
//       final payments = await StudentService.getPayments();
//       if (payments.isNotEmpty) {
//         print(payments);
//         setState(() {
//           _paymentDetails = payments.first;
//         });
//       }
//     } catch (error) {
//       print('Error fetching payment details: $error');
//     }
//   }

//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles();

//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         _receiptFile = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<void> _uploadAndPostPayment() async {
//     if (_receiptFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text('Please select a receipt file.'),
//         backgroundColor: Colors.red,
//       ));
//       return;
//     }

//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       final storageRef = FirebaseStorage.instance.ref().child('receipts/$fileName');

//       final uploadTask = storageRef.putFile(_receiptFile!);

//       uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//         setState(() {
//           _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
//         });
//       });

//       await uploadTask.whenComplete(() => {});

//       final downloadUrl = await storageRef.getDownloadURL();

//       setState(() {
//         _isUploading = false;
//       });

//       print('File uploaded successfully. URL: $downloadUrl');

//       // Post payment details to backend
//       bool paymentPosted = await StudentService.postPayment(
//         photoUrl: downloadUrl,
//         teacherEmail: widget.teacherEmail,
//         subject: widget.subject,
//         medium: widget.medium,
//         bankName: _paymentDetails?.bankName ?? 'N/A',
//         accountNo: _paymentDetails?.accountNo ?? 'N/A',
//       );

//       if (paymentPosted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: const Text('Payment posted successfully.'),
//           backgroundColor: Colors.green,
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: const Text('Failed to post payment.'),
//           backgroundColor: Colors.red,
//         ));
//       }
//     } catch (error) {
//       print('Error uploading file and posting payment: $error');
//       setState(() {
//         _isUploading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text('Error uploading file and posting payment.'),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tuition Fee'),
//         backgroundColor: Colors.blue,
//         foregroundColor: const Color.fromARGB(255, 0, 0, 0),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (_paymentDetails != null) ...[
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text.rich(
//                           TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Teacher Email: ',
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                               ),
//                               TextSpan(
//                                 text: _paymentDetails!.teacherEmail ?? 'N/A',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text.rich(
//                           TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Bank Name: ',
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                               ),
//                               TextSpan(
//                                 text: _paymentDetails!.bankName ?? 'N/A',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text.rich(
//                           TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Account No: ',
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                               ),
//                               TextSpan(
//                                 text: _paymentDetails!.accountNo ?? 'N/A',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text.rich(
//                           TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Subject: ',
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                               ),
//                               TextSpan(
//                                 text: _paymentDetails!.subject ?? 'N/A',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text.rich(
//                           TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Medium: ',
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                               ),
//                               TextSpan(
//                                 text: _paymentDetails!.medium ?? 'N/A',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ] else ...[
//                 CircularProgressIndicator(),
//                 const SizedBox(height: 16),
//                 const Text('Fetching payment details...')
//               ],
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: _pickFile,
//                 child: const Text('Pick Receipt'),
//               ),
//               if (_receiptFile != null)
//                 Text(
//                   'File selected: ${_receiptFile!.path.split('/').last}',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               const SizedBox(height: 32),
//               if (_isUploading)
//                 CircularProgressIndicator(value: _uploadProgress)
//               else
//                 ElevatedButton(
//                   onPressed: _uploadAndPostPayment,
//                   child: const Text('Upload Receipt'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

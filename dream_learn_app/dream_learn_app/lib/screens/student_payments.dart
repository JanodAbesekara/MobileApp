import 'dart:io';

import 'package:dream_learn_app/helpers/student_helper.dart';
import 'package:dream_learn_app/models/student_class_fee.dart';
import 'package:dream_learn_app/services/student_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StudentTutionFees extends StatelessWidget {
  final String? teacherEmail;
  final String? subject;
  final String? medium;

  const StudentTutionFees({required this.teacherEmail,required this.subject,required this.medium,  super.key});

  Future<StudentClassFee> _getClassFeeDetails()async{
      StudentClassFee? filteredFee;
   List<StudentClassFee>  feeList=  await StudentService.getPayments(studentEmail);
     try { 
      filteredFee = feeList.firstWhere((quz) =>
          quz.teacherEmail == teacherEmail &&
          quz.subject ==subject &&
          quz.medium == medium);
         
    } catch (err) {
      // Handle error
      rethrow;
    }

    return filteredFee;

  }

 Future _onFileSelection()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

if (result != null) {
  File file = File(result.files.single.path!);
} else {
  // User canceled the picker
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Student Payments'),),
    body:  Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<StudentClassFee>(
        future: _getClassFeeDetails(),
        builder: (ctx,snapshot){
      
          if(snapshot.hasError){
            return const Center(child: Text('having loading error...'),);
          }
      
          if(snapshot.hasData){
       return   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            Container(
              padding: const EdgeInsets.all(3),
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
 Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Teacher email - ',style: TextStyle(fontSize: 20),),
                Text('${snapshot.data!.teacherEmail}',style: const TextStyle(fontSize: 16))
            ],
           ),
            Row(
            children: [
              const Text('Bank Name - ',style: TextStyle(fontSize: 20)),
                Text('${snapshot.data!.bankName}',style: const TextStyle(fontSize: 16))
            ],
           ),
             Row(
            children: [
              const Text('Account no - ',style: TextStyle(fontSize: 20)),
                Text('${snapshot.data!.accountNo}',style: const TextStyle(fontSize: 16))
            ],
           ),
            Row(
            children: [
               const Text('Class fee - ',style: TextStyle(fontSize: 20)),
                Text('${snapshot.data!.classFee}',style: const TextStyle(fontSize: 16))
            ],
           ),

           ElevatedButton(onPressed: ()async=> await _onFileSelection(), child: const Text(
              'Upload Recipt'
           ))
          ],
        ),
            )
          
          ],
        );
          }
      
          return const Center(child: CircularProgressIndicator(),);
         
        }  
          
      ),
    ),
    
    
    );
  }
}
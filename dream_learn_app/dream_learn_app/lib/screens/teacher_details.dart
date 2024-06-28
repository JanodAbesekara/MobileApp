import 'package:dream_learn_app/models/teacher.dart';
import 'package:dream_learn_app/services/teacher_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TeacherDetails extends StatelessWidget {
  final String teacherEmail;
  const TeacherDetails({required this.teacherEmail, super.key});

 Future<Teacher> _getTeacherDetails() async{
 List<Teacher> teacherList= await TeacherService.getTeachers();
 final Teacher teacher;
 try{
 teacher= teacherList.firstWhere((teacher) => teacher.email==teacherEmail);
 
return teacher;
 }catch(err){
  throw 'teacher cannot find';
 }


  
  

  }

  _infoRow(IconData icon,String title,String value){
    return   Row(
                
                  children: [
                    Icon(icon),
                    const SizedBox(width: 20),
                    Text('$title - '),
                     
                    Text(value)
                  ],
                );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'),
      ),
      body:  FutureBuilder(
        future: _getTeacherDetails(),
        builder:(context, snapshot) {

          if(snapshot.hasData){
  return Column(   
          children: [
            const SizedBox(height: 50),
            const SizedBox(
              width: 156,
              height: 156,
              child: CircleAvatar()),
              Text('${snapshot.data!.firstName} ${snapshot.data!.lastName}',style: TextStyle(
                fontSize: 24,
                color: Colors.purple.shade400
             
              ),),
              const SizedBox(height:10,),
        
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(Icons.phone,'Number','${snapshot.data!.phoneNumber}'),
                          const SizedBox(height: 20),
                           _infoRow(Icons.email,'Email','${snapshot.data!.email}'),
                            const SizedBox(height: 20),
                            _infoRow(Icons.date_range,'Joined on',DateFormat('d MMMM yyyy, h:mm a').format(snapshot.data!.date!)),
                        ],
                      )
                    ),
                  ),]
                ),
              )
               
          ],
        );
          }

          if(snapshot.hasError){
            print('having error loading teacher details');

          }

          return const Center(child: CircularProgressIndicator());


        
        } ,
       
      ),
    );
  }
}
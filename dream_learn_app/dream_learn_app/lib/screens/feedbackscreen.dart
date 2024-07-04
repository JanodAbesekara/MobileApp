import 'package:dream_learn_app/services/student_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackScaren extends StatelessWidget {
   FeedbackScaren({super.key});
  TextEditingController feedtext=TextEditingController();
    TextEditingController value=TextEditingController();
      TextEditingController teacheremail=TextEditingController();
        TextEditingController feedSubject=TextEditingController();
       TextEditingController   feedmedium=TextEditingController();




 Future<bool> _onSubmit()async{
final bool isSuccess= await StudentService. postFeedback(feedtext.text,value.text,teacheremail.text,feedSubject.text,feedmedium.text);
 
 return isSuccess;
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Feedback'),),
      body:  Column(
        children: [
          const Text('feedback'),
           TextField(
            controller: feedtext,

          ),
          const SizedBox(height: 20,),
           const Text('value'),
           TextField(
controller: value,
          ),
          const SizedBox(height: 20,),
           const Text('teacher email'),
           TextField(
controller: teacheremail,
          ),
          const SizedBox(height: 20,),
           const Text('feedSubject'),
           TextField(
controller: feedSubject,
          ),
           const Text('feedmedium'),
           TextField(
controller:feedmedium ,
          ),

          TextButton(onPressed: ()async{
       final bool success=   await _onSubmit()  ;
       if(success){
         var snackBar = const SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: Text("Feedback Added Successfully!"),
        ),
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
       }
                  }, child: const Text('Submit'))
        ],
      ),
    );
  }
}

import 'package:dream_learn_app/services/student_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackScaren extends StatelessWidget {
  FeedbackScaren({super.key});
  TextEditingController feedtext = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController teacheremail = TextEditingController();
  TextEditingController feedSubject = TextEditingController();
  TextEditingController feedmedium = TextEditingController();

  Future<bool> _onSubmit() async {
    final bool isSuccess = await StudentService.postFeedback(
      feedtext.text,
      value.text,
      teacheremail.text,
      feedSubject.text,
      feedmedium.text,
    );

    return isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedbacks'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Feedback',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: feedtext,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your feedback',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Value',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter value',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Teacher Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: teacheremail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter teacher email',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Subject',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: feedSubject,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter subject',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Medium',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: feedmedium,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter medium',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final bool success = await _onSubmit();
                    if (success) {
                      var snackBar = const SnackBar(
                        content: Align(
                          alignment: Alignment.center,
                          child: Text("Feedback Added Successfully!"),
                        ),
                        backgroundColor: Color.fromARGB(255, 11, 11, 11),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
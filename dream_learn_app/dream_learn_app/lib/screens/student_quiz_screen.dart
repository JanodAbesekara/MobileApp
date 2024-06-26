import 'package:flutter/material.dart';
import 'package:dream_learn_app/models/quiz.dart';
import 'package:dream_learn_app/services/quiz_service.dart';

class StudentQuizScreen extends StatefulWidget {
  final String? teacherEmail;
  final String? subject;
  final String? medium;
  const StudentQuizScreen({super.key, this.teacherEmail, this.subject, this.medium});

  @override
  State<StudentQuizScreen> createState() => _StudentQuizScreenState();
}

class _StudentQuizScreenState extends State<StudentQuizScreen> {
  List<int?> selectedOptions = [];
   Quiz? _loadedQuiz;
   int correctAnswercount=0;

  @override
  void initState() {
    super.initState();
  }

  Future<Quiz?> _getQuiz() async {
    Quiz? _filteredQuiz;
    List<Quiz> _quizList = await QuizService.getQuizList();
   
    try {
      _filteredQuiz = _quizList.firstWhere((quz) =>
          quz.teacherEmail == widget.teacherEmail &&
          quz.subject == widget.subject &&
          quz.medium == widget.medium);
          _loadedQuiz=_filteredQuiz;
    } catch (err) {
      // Handle error
    }

    return _filteredQuiz;
  }

  void checkCorrections(){
    correctAnswercount=0;
    int questionsLength= _loadedQuiz?.questions?.length ?? 0;

    
    for(int i=0;i<questionsLength;i++){
      if(  _loadedQuiz?.questions?[i].correctAnswerIndex ==  (selectedOptions[i] ?? 0)){
        correctAnswercount++;
        setState(() {
          
        });
      } 
    

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [FutureBuilder<Quiz?>(
            future: _getQuiz(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('having error loading quiz list: ' + snapshot.error.toString());
                return Center(child: Text('Error loading quizzes'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No Quizzes'));
              } else {
                Quiz quiz = snapshot.data!;
          
                // Initialize selectedOptions list with null values for each question
                if (selectedOptions.isEmpty) {
                  selectedOptions = List<int?>.filled(quiz.questions!.length, null);
                }
          
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: quiz.questions!.asMap().entries.map((entry) {
                    int questionIndex = entry.key;
                    var ques = entry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        // Title
                        Text(
                          (questionIndex + 1).toString() + '. ' + (ques.questionTitle ?? ''),
                          style: TextStyle(fontSize: 17),
                        ),
                        const SizedBox(height: 20),
                        // Answer list
                        ...ques.answerList!.asMap().entries.map((answerEntry) {
                          int answerIndex = answerEntry.key;
                          var answer = answerEntry.value;
                          return ListTile(
                            title: Text(answer),
                            leading: Radio<int>(
                              groupValue: selectedOptions[questionIndex],
                              value: answerIndex + 1,
                              onChanged: (val) {
                                setState(() {
                                  selectedOptions[questionIndex] = val;
                                });
                                checkCorrections();
                              },
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
          
          Text('correct answers = '+correctAnswercount.toString(),style: TextStyle(
            color: Colors.purple,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),)]
        ),
      ),
    );
  }
}

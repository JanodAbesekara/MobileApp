class Quiz{
  String? teacherEmail;
  String? subject;
  String? medium;
 List<Question>? questions;


 Quiz.fromJson(Map<String,dynamic> json){
  try{
     teacherEmail=json['TeacherEmail'];
  subject=json['TeacherSubject'];
  medium= json['submedium'];
  questions=(json['question'] as List).map((ques) => Question.fromJson(ques)).toList();
  }catch(err){
print(err.toString());
  }
 

 }


}

class Question{
  String? questionTitle;
  int? correctAnswerIndex;
  List<String>? answerList;

Question.fromJson(Map<String,dynamic> json){
  questionTitle=json['Question'];
  correctAnswerIndex=json['correctAnswerIndex'];
  answerList=(json['answers'] as List).map((answer) => answer).cast<String>().toList();

}



}
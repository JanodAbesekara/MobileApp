import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class Feedbacksview extends StatefulWidget {
  const Feedbacksview({Key? key}) : super(key: key);

  @override
  _FeedbacksviewState createState() => _FeedbacksviewState();
}

class _FeedbacksviewState extends State<Feedbacksview> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _feedbacks(context),
    );
  }

  Widget _feedbacks(BuildContext context) {
    return Column(
    
    );
  }
}

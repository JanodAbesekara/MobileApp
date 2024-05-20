import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class QuizessT extends StatefulWidget {
  const QuizessT({Key? key}) : super(key: key);

  @override
  _QuizessTState createState() => _QuizessTState();
}

class _QuizessTState extends State<QuizessT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (details) {
              if (details.localPosition.dx < 50 &&
                  details.localPosition.dy < 50) {
                Navigator.of(context).pop();
              }
            },
            child: BackgroundScreen(
              child: _buildChild(context),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: 80,
              height: 80,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: Colors.transparent, // Invisible area
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quizzes',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20.0), // Add spacing between the title and row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
            ],
          ),
        ],
      ),
    );
  }
}

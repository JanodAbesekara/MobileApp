import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';
import 'package:dream_learn_app/services/feedback_service.dart';

class Feedbacksview extends StatelessWidget {
  const Feedbacksview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundScreen(
            child: _feedbacks(context),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _feedbacks(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: FeedbackService.getFeedback(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No feedback available'));
        } else {
          List<Map<String, dynamic>> feedbackList = snapshot.data!;
          return Container(
            height: MediaQuery.of(context)
                .size
                .height, // Example: Use screen height
            child: ListView.builder(
              itemCount: feedbackList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> feedback = feedbackList[index];
                return Feedbackcard(
                  studentemail: feedback['studentemail'],
                  feedtext: feedback['feedtext'],
                  value: feedback['value'].toDouble(),
                  subject: feedback['feedSubject'],
                  medium: feedback['feedmedium'],
                );
              },
            ),
          );
        }
      },
    );
  }
}

class Feedbackcard extends StatelessWidget {
  final String studentemail;
  final String feedtext;
  final double value;
  final String subject;
  final String medium;

  const Feedbackcard({
    Key? key,
    required this.studentemail,
    required this.feedtext,
    required this.value,
    required this.subject,
    required this.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              studentemail,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(feedtext),
          SizedBox(height: 10),
          StarRating(rating: value),
          SizedBox(height: 10),
          Text(
            subject,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Text(
            medium,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;

  const StarRating({
    Key? key,
    required this.rating,
    this.starCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        starCount,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        ),
      ),
    );
  }
}

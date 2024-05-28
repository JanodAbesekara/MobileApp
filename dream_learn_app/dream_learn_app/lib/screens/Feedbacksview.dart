import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

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
    return Column(
      children: [
        Feedbackcard(
          studentmail: 'adas@gmail.com',
          feedbackmessage: 'good',
          feedbakrating: 4.5,
        ),
        Feedbackcard(
          studentmail: 'adasd@gamil.com',
          feedbackmessage: 'bad',
          feedbakrating: 2.5,
        ),
        // Add more Feedbackcard widgets as needed
      ],
    );
  }
}

class Feedbackcard extends StatelessWidget {
  final String studentmail;
  final String feedbackmessage;
  final double feedbakrating;

  const Feedbackcard({
    Key? key,
    required this.studentmail,
    required this.feedbackmessage,
    required this.feedbakrating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
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
        children: [
          Row(
            children: [
              Text('Student Email: '),
              Text(studentmail),
            ],
          ),
          Row(
            children: [
              Text('Feedback Message: '),
              Text(feedbackmessage),
            ],
          ),
          Row(
            children: [
              Text('Feedback Rating: '),
              StarRating(rating: feedbakrating),
            ],
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
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        ),
      ),
    );
  }
}

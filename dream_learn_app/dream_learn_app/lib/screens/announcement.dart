import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/ApplicationinsideNot.dart';


class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const
         Text(
          'Announcements',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color.fromARGB(85, 26, 26, 26),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 189, 179, 179),
      ),
      body: Stack(
        children: [
          // Background image
          BackgroundScreen(
            child: Container(),
          ),
          // Content
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent, // Make the container transparent
            ),
            child: _Announcements(context),
          ),
        ],
      ),
    );
  }

  Widget _Announcements(BuildContext context) {
    return ListView(
      children: [
        AnnouncementCard(
          title: 'Important Announcement 1',
          description: 'This is the first important announcement.',
          date: '2021-10-01',
        ),
        AnnouncementCard(
          title: 'Important Announcement 2',
          description: 'This is the second important announcement.',
          date: '2021-10-01',
        ),
        // Add more AnnouncementCard widgets here for additional announcements
      ],
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String date; // Changed from Date to date

  const AnnouncementCard({
    required this.title,
    required this.description,
    required this.date, // Changed from Date to date
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

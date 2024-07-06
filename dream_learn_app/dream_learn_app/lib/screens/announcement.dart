import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/ApplicationinsideNot.dart';
import 'package:dream_learn_app/services/announcement_services.dart';

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
        title: Text(
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
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: AnnouncementServices.getAnnouncement(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No announcements available'));
          } else {
            List<Map<String, dynamic>> announcementList = snapshot.data!;
            return ListView.builder(
              itemCount: announcementList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> announcement = announcementList[index];
                return AnnouncementCard(
                  title: announcement['titleofAnn'] ?? '',
                  description: announcement['Announcementmessage'] ?? '',
                  date: (announcement['date'] as String).split("T")[0] ?? '',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const AnnouncementCard({
    required this.title,
    required this.description,
    required this.date,
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
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 10,
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



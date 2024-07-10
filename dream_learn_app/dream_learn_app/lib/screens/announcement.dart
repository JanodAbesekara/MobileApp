import 'package:flutter/material.dart';
import 'package:dream_learn_app/services/tannoucement_services.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: Colors.blue,  // Updated background color
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: AnnouncementServices.getAnnouncement(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No announcements available'));
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: const Color.fromARGB(255, 224, 224, 224),
              thickness: 1,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,  // Added line height for better readability
              ),
            ),
            const SizedBox(height: 12),
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


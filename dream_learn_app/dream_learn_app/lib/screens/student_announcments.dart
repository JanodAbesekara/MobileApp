import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/ApplicationinsideNot.dart';
import 'package:dream_learn_app/services/announcement_services.dart';

class StudentAnnouncement extends StatefulWidget {
   final String? teacherEmail;
  final String? subject;
  final String? medium;
  const StudentAnnouncement({this.teacherEmail,this.subject,this.medium, super.key});

  @override
  _StudentAnnouncementState createState() => _StudentAnnouncementState();
}



class _StudentAnnouncementState extends State<StudentAnnouncement> {
  Future<List<Map<String, dynamic>>> _filterAnnouncements()async{ 
  List<Map<String, dynamic>> filteredAnnouncementList=[];
List<Map<String, dynamic>> announcementList= await  AnnouncementServices.getStudentAnnouncement() ??[];
 try { 
    // filteredAnnouncementList=  announcementList.where((item) =>
    //       item['postedemail'] == widget.teacherEmail &&
    //       item['TeacheSubject'] == widget.subject &&
    //       item['mediua'] == widget.medium).toList();

    //   print('listttt->${filteredAnnouncementList.length}');
    for(int i=0;i<announcementList.length;i++){
      final item= announcementList[i];
      if(item['postedemail'] == widget.teacherEmail &&
          item['TeacheSubject'] == widget.subject &&
          item['mediua'] == widget.medium){
           filteredAnnouncementList.add(item);

      }

    }
      return filteredAnnouncementList;
          
    } catch (err) {
      // Handle error
      return [];
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: Colors.blue,
      ),
      
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future:_filterAnnouncements(),
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
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: const TextStyle(
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

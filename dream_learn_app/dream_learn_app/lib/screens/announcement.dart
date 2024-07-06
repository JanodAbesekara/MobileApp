import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _Announcements(context),
    );
  }

  Widget _Announcements(BuildContext context) {
    return Column(
    
    );
  }
}
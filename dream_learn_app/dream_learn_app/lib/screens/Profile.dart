import 'package:flutter/material.dart';
import 'package:dream_learn_app/screens/background.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: _profile(context),
    );
  }

  Widget _profile(BuildContext context) {
    return Column(
     
    );
  }
}

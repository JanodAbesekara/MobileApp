import 'package:flutter/material.dart';


class LectureMaterialT extends StatelessWidget {
  const LectureMaterialT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _launchURL("https://chatgpt.com/g/g-2DQzU5UZl-code-copilot/c/7a520fbb-15e4-4621-b48d-ebad621560dd");

    return Scaffold(
      body: Stack(
        // Empty stack or you can add your desired UI here.
      ),
    );
  }

  void _launchURL(String url) async {
   
  }
}

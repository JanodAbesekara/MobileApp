import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackgroundScreen extends StatelessWidget {
  final Widget child;
  const BackgroundScreen({required this.child, Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

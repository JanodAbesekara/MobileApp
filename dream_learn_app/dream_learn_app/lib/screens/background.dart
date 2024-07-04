import 'package:dream_learn_app/screens/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BackgroundScreen extends StatelessWidget {
  final bool shouldShowSidebar;
  final bool shouldShowBackButton;
  final Widget child;
  const BackgroundScreen({super.key, required this.child,this.shouldShowSidebar=false,this.shouldShowBackButton=true});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                  GestureDetector(
                    onTap: () {
                      _launchURL(
                          "https://byte-group-project.vercel.app/TClasses?\$phw=66444f765aca7cfaf2bcedc4");
                    },
                    child: Image.asset("assets/logo.png"),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        child,
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Tuition class Management System',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        if(shouldShowBackButton==true)
            Positioned(
              
              child:    IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon:const Icon( Icons.arrow_back))),

               if(shouldShowSidebar==true)
                Positioned(
                  right: 0,
              child:IconButton(
                        onPressed: () {
                              Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const SideBar()));
                        },
                        icon: const Icon(
                              Icons.menu,
                              color: Colors.blue,
                        )))
             


          ],
        ),
      ),
    );
  }
}

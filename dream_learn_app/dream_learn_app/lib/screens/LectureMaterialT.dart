import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LectureMaterialT extends StatefulWidget {
  const LectureMaterialT({Key? key}) : super(key: key);

  @override
  _LectureMaterialTState createState() => _LectureMaterialTState();
}

class _LectureMaterialTState extends State<LectureMaterialT> {
  @override
  void initState() {
    super.initState();
    _launchURL("https://byte-group-project.vercel.app/TClasses?\$phw=66444f765aca7cfaf2bcedc4");
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Material'),
      ),
      body: Center(
        child: Text('Redirecting to the web page...'),
      ),
    );
  }
}

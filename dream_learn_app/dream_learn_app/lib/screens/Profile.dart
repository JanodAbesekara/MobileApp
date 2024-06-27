import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/screens/AppInsideBackground.dart';
import 'package:dream_learn_app/services/ProfileService.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<List<Map<String, dynamic>>?> _profileDataFuture;
  late Future<Map<String, String>?> _nameFuture;

  @override
  void initState() {
    super.initState();
    _profileDataFuture = getProfileList();
    _nameFuture = getName();
  }

  Future<List<Map<String, dynamic>>?> getProfileList() async {
    try {
      return await ProfileService.getProfileDataFromToken();
    } catch (e) {
      print('Error fetching profile data: $e');
      return null;
    }
  }

  Future<Map<String, String>?> getName() async {
    try {
      return await ProfileService.getNameFromToken();
    } catch (e) {
      print('Error fetching name from token: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundScreen(
            child: _passChild(context),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    return CircleAvatar(
      radius: 80,
      backgroundImage: NetworkImage(imageUrl ?? ''),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildNameAndDate(String firstName, String lastName) {
    return Column(
      children: [
        Text(
          '$firstName $lastName',
          style: GoogleFonts.roboto(
            color: Color(0xFF180565),
            fontSize: 20,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _passChild(BuildContext context) {
    return FutureBuilder<Map<String, String>?>(
      future: _nameFuture,
      builder: (context, nameSnapshot) {
        if (nameSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (nameSnapshot.hasError) {
          return Center(child: Text('Error: ${nameSnapshot.error}'));
        } else if (!nameSnapshot.hasData || nameSnapshot.data!.isEmpty) {
          return Center(child: Text('No name found'));
        } else {
          final firstName = nameSnapshot.data!['firstName']!;
          final lastName = nameSnapshot.data!['lastName']!;
          return FutureBuilder<List<Map<String, dynamic>>?>(
            future: _profileDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              } else {
                List<Map<String, dynamic>> profileList = snapshot.data!;
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      _buildNameAndDate(firstName, lastName),
                      Expanded(
                        child: ListView.builder(
                          itemCount: profileList.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> profile = profileList[index];
                            return ProfileCard(
                              subject: profile['subject'],
                              medium: profile['medium'],
                              classfees: profile['classpees'],
                              aboutme: profile['aboutme'],
                              experience: profile['experience'],
                              degree: profile['degree'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String subject;
  final String medium;
  final String classfees;
  final String aboutme;
  final String experience;
  final String degree;

  const ProfileCard({
    Key? key,
    required this.subject,
    required this.medium,
    required this.classfees,
    required this.aboutme,
    required this.experience,
    required this.degree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject: $subject',
            style: GoogleFonts.roboto(
              color: Color(0xFF180565),
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Medium: $medium',
            style: GoogleFonts.roboto(
              color: Color(0xFF180565),
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Classfees: Rs. $classfees.00',
            style: GoogleFonts.roboto(
              color: Color(0xFF180565),
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'About Me: $aboutme',
            style: GoogleFonts.roboto(
              color: Color(0xFF180565),
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Experience: $experience',
            style: GoogleFonts.roboto(
              color: Color(0xFF180565),
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Degree: $degree',
            style: GoogleFonts.roboto(
              color: Color(0xFF180565),
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
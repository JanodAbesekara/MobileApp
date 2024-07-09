import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dream_learn_app/services/ProfileService.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

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

  Widget _buildNameAndDate(String firstName, String lastName) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: Text(
              '$firstName $lastName',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _passChild(BuildContext context) {
    return FutureBuilder<Map<String, String>?>(
      future: _nameFuture,
      builder: (context, nameSnapshot) {
        if (nameSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (nameSnapshot.hasError) {
          return Center(child: Text('Error: ${nameSnapshot.error}'));
        } else if (!nameSnapshot.hasData || nameSnapshot.data!.isEmpty) {
          return const Center(child: Text('No name found'));
        } else {
          final firstName = nameSnapshot.data!['firstName'] ?? 'N/A';
          final lastName = nameSnapshot.data!['lastName'] ?? 'N/A';
          return FutureBuilder<List<Map<String, dynamic>>?>(
            future: _profileDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data found'));
              } else {
                List<Map<String, dynamic>> profileList = snapshot.data!;
                return SizedBox(
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
                              subject: profile['subject'] ?? 'N/A',
                              medium: profile['medium'] ?? 'N/A',
                              classfees: profile['classfees'] ?? 'N/A',
                              aboutme: profile['aboutme'] ?? 'N/A',
                              experience: profile['experience'] ?? 'N/A',
                              degree: profile['degree'] ?? 'N/A',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: _passChild(context),
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
    super.key,
    required this.subject,
    required this.medium,
    required this.classfees,
    required this.aboutme,
    required this.experience,
    required this.degree,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 251, 252, 254),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: 'Subject: ',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: subject,
                  style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Medium: ',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: medium,
                  style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Classfees: ',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Rs. $classfees.00',
                  style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'About Me: ',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: aboutme,
                  style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Experience: ',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: experience,
                  style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Degree: ',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: degree,
                  style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

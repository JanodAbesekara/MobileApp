
import 'package:dream_learn_app/screens/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({super.key});
  
  static final TextStyle _titleStyles = TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 34, letterSpacing: 5, fontWeight: FontWeight.bold);
  static const TextStyle _contactDetailsStyles = TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  Widget _textContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: child,
    );
  }

  Widget _passChild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 50,
        ),
        
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
            color: Color(0xffD9D9D9)
          ),
          child: Text(
            'About Us',
            style: _titleStyles,
          ),
        ),
      
        const SizedBox(
          height: 20,
        ),
        const Text('Welcome to DreamLearn Academy, your partner in academic excellence and personal growth. Established with a passion for education and a commitment to nurturing young minds, DreamLearn is more than just a tuition center – it\'s a hub of learning innovation and student empowerment.At DreamLearn, we understand that every student is unique, with their own strengths, weaknesses, and aspirations. That\'s why we\'ve crafted a holistic approach to education that goes beyond traditional teaching methods. Our team of experienced educators is dedicated to creating personalized learning experiences tailored to the individual needs of each student. Through a blend of interactive lessons, hands-on activities, and one-on-one guidance, we strive to ignite a lifelong love for learning and equip students with the skills they need to succeed in an ever-evolving world.But we\'re more than just academics – at DreamLearn, we foster a supportive and inclusive community where students feel valued, motivated, and empowered to reach for their dreams. Whether it\'s boosting confidence, building resilience, or fostering creativity, our holistic approach to education focuses on nurturing the whole student, not just their academic achievements. DreamLearn Academy is here to accompany students on every step of their educational journey. Join us today and let\'s unlock your full potential together.',style: TextStyle(fontSize: 15),)
     ,
        const SizedBox(height: 35,),
      


      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(shouldShowBackButton: true,child: _passChild(),);
  }
}

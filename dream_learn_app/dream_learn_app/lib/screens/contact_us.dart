import 'package:dream_learn_app/screens/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactUS extends StatelessWidget {
  const ContactUS({super.key});
  
  static final TextStyle _titleStyles = TextStyle(color:  Colors.black.withOpacity(0.5), fontSize: 34, letterSpacing: 5, fontWeight: FontWeight.bold);
    static final TextStyle _contactDetailsStyles = TextStyle(color:  Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

    Widget _textContainer(Widget child){
      return Padding(
          padding: const EdgeInsets.only(left: 15),
          child:child ,
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
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Color(0xffD9D9D9)
          ),
           child: Text(
            'Contact Us',
            style: _titleStyles,
                   ),
         ),
      
    
        const SizedBox(
          height: 100,
        ),
        _textContainer(
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Telephone - ',style: _contactDetailsStyles,),
              Column(
                children: [
                   Text('(011 123 4567',style: _contactDetailsStyles,),
                    Text('(8.00 pm - 6.00am )',style: _contactDetailsStyles,),
                ],
              )
          
            ],
          ),
        ),
        const SizedBox(height: 35,),
            _textContainer(
        Text('Email - dreamlearnacademy@gmail.com',style: _contactDetailsStyles,),

        ),

        const SizedBox(height:100),
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [GestureDetector(
            onTap: (){
              print('get help clicked');
            },
            child: Image.asset('assets/get_help.png',height: 50,)),SizedBox(width: 30,)]) ,

            SizedBox(height: 25,)
        

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(child: _passChild());
  }
}

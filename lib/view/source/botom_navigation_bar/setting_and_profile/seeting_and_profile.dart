import 'package:flutter/material.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';

import '../../../components/onbording_text/onbording_text.dart';
class SeetingAndProfile extends StatefulWidget {
  const SeetingAndProfile({super.key});

  @override
  State<SeetingAndProfile> createState() => _SeetingAndProfileState();
}

class _SeetingAndProfileState extends State<SeetingAndProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: CircleAvatar(radius: 60,backgroundColor: Colors.red,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 50),
            child:      OnbordingText(text1: 'Name',
              color: Appcolors.black, size:12, fontWeight: FontWeight.bold,)
          ),

         // Card(child: Container(),)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';
import '../../components/onbording_text/button/lets_start_button.dart';
import '../../components/onbording_text/onbording_text.dart';
import '../auth_screens/login_screen/auth_screens.dart';
class OnbordingScreens extends StatefulWidget {
  const OnbordingScreens({super.key});

  @override
  State<OnbordingScreens> createState() => _OnbordingScreensState();
}

class _OnbordingScreensState extends State<OnbordingScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
         Padding(
           padding: const EdgeInsets.only(top: 80),
           child: Container(
             height: 350,
             width: 300,
             decoration: BoxDecoration(
               image: DecorationImage(image: AssetImage('assets/onboarding1.png'))
             ),
           ),
         ),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: OnbordingText(text1: 'Simplify, Organize,and ',
                color: Appcolors.black, size: 30, fontWeight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  OnbordingText(text1: 'Conquer',
                    color: Appcolors.black, size: 30, fontWeight: FontWeight.bold,),
                  OnbordingText(text1: ' Your Day',
                    color: Appcolors.maincolor, size: 30, fontWeight: FontWeight.bold,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0,top: 10),
              child: OnbordingText(text1: 'Take control of your tasks and ',
                color: Appcolors.black, size: 10, fontWeight: FontWeight.normal,),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: OnbordingText(text1: 'achieve your goals.',
                color: Appcolors.black, size: 10, fontWeight: FontWeight.normal,),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0,top: 50),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreens()));
                },
                child: LetsStartButton(height: 40, width: 200, text1: 'Lets Start', size: 20, fontWeight: FontWeight.w600,
                  colortext: Appcolors.white, colorCont: Appcolors.maincolor,),
              )
            ),
        
          ],
        ),
      ),
    );
  }
}

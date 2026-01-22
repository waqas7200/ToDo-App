import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';
import '../../components/onbording_text/button/lets_start_button.dart';
import '../../components/onbording_text/onbording_text.dart';
import '../auth_screens/login_screen/lodin.dart';
import '../botom_navigation_bar/botom_navigation-bar.dart';

class OnbordingScreens extends StatefulWidget {
  const OnbordingScreens({super.key});

  @override
  State<OnbordingScreens> createState() => _OnbordingScreensState();
}

class _OnbordingScreensState extends State<OnbordingScreens> {

  @override
  void initState() {
    super.initState();
    userVerification();
  }

  /// 🔐 USER CHECK (LOGIN / LOGOUT)
  void userVerification() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay

    User? user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreens()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BotomNavigation_bar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),

            Container(
              height: 350,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/onboarding1.png'),
                ),
              ),
            ),

            const SizedBox(height: 20),

            OnbordingText(
              text1: 'Simplify, Organize,and ',
              color: Appcolors.black,
              size: 30,
              fontWeight: FontWeight.bold,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OnbordingText(
                  text1: 'Conquer ',
                  color: Appcolors.black,
                  size: 30,
                  fontWeight: FontWeight.bold,
                ),
                OnbordingText(
                  text1: 'Your Day',
                  color: Appcolors.maincolor,
                  size: 30,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            const SizedBox(height: 10),

            OnbordingText(
              text1: 'Take control of your tasks and',
              color: Appcolors.black,
              size: 10,
              fontWeight: FontWeight.normal,
            ),
            OnbordingText(
              text1: 'achieve your goals.',
              color: Appcolors.black,
              size: 10,
              fontWeight: FontWeight.normal,
            ),

            const SizedBox(height: 50),

            /// OPTIONAL BUTTON (manual navigation)
            // InkWell(
            //   onTap: () {
            //     User? user = FirebaseAuth.instance.currentUser;
            //
            //     if (user == null) {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => AuthScreens()),
            //       );
            //     } else {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => BotomNavigation_bar()),
            //       );
            //     }
            //   },
            //   child: LetsStartButton(
            //     height: 40,
            //     width: 200,
            //     text1: 'Lets Start',
            //     size: 20,
            //     fontWeight: FontWeight.w600,
            //     colortext: Appcolors.white,
            //     colorCont: Appcolors.maincolor,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}





// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_app/view/utills/appcolors/appcolors.dart';
// import '../../components/onbording_text/button/lets_start_button.dart';
// import '../../components/onbording_text/onbording_text.dart';
// import '../auth_screens/login_screen/lodin.dart';
// import '../botom_navigation_bar/botom_navigation-bar.dart';
// import '../botom_navigation_bar/Home_screens/home_screen.dart';
// class OnbordingScreens extends StatefulWidget {
//   const OnbordingScreens({super.key});
//
//   @override
//   State<OnbordingScreens> createState() => _OnbordingScreensState();
// }
//
// class _OnbordingScreensState extends State<OnbordingScreens> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     user_verification();
//   }
//   user_verification()async{
//     String userid=await FirebaseAuth.instance.currentUser!.uid;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//          Padding(
//            padding: const EdgeInsets.only(top: 80),
//            child: Container(
//              height: 350,
//              width: 300,
//              decoration: BoxDecoration(
//                image: DecorationImage(image: AssetImage('assets/onboarding1.png'))
//              ),
//            ),
//          ),
//             Padding(
//               padding: const EdgeInsets.only(right: 0),
//               child: OnbordingText(text1: 'Simplify, Organize,and ',
//                 color: Appcolors.black, size: 30, fontWeight: FontWeight.bold,),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 50),
//               child: Row(
//                 children: [
//                   OnbordingText(text1: 'Conquer',
//                     color: Appcolors.black, size: 30, fontWeight: FontWeight.bold,),
//                   OnbordingText(text1: ' Your Day',
//                     color: Appcolors.maincolor, size: 30, fontWeight: FontWeight.bold,),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 0,top: 10),
//               child: OnbordingText(text1: 'Take control of your tasks and ',
//                 color: Appcolors.black, size: 10, fontWeight: FontWeight.normal,),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 0),
//               child: OnbordingText(text1: 'achieve your goals.',
//                 color: Appcolors.black, size: 10, fontWeight: FontWeight.normal,),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 0,top: 50),
//               child: InkWell(
//                 onTap: ()async{
//                  String userid=await FirebaseAuth.instance.currentUser!.uid;
//                  if(userid==null || userid==""){
//                    Navigator.pushReplacement(context, MaterialPageRoute
//                      (builder: (context)=>AuthScreens()));
//                  }
//                  else {
//                    Navigator.pushReplacement(context, MaterialPageRoute
//                      (builder: (context)=>BotomNavigation_bar()));
//                  }
//
//                 },
//                 child: LetsStartButton(height: 40, width: 200, text1: 'Lets Start', size: 20, fontWeight: FontWeight.w600,
//                   colortext: Appcolors.white, colorCont: Appcolors.maincolor,),
//               )
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

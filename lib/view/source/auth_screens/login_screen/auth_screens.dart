import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';

import '../../../components/email_textformfield/email_textfomfield.dart';
import '../../../components/onbording_text/button/lets_start_button.dart';
import '../../../components/onbording_text/onbording_text.dart';
import '../../../components/password_texformfield/password_tex_form_field.dart';
import '../../botom_navigation_bar/botom_navigation-bar.dart';
import '../../home_screen/home_screen.dart';
import '../sign_up/sign_up.dart';
class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}
TextEditingController emailcontroller=TextEditingController();
TextEditingController passwordcontroller=TextEditingController();
class _AuthScreensState extends State<AuthScreens> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      appBar: AppBar(
          backgroundColor: Appcolors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: OnbordingText(text1: 'Welcome Back', color: Appcolors.black,

            size: 25, fontWeight: FontWeight.bold,),
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30,top: 30),
              child:OnbordingText(text1: 'Login', color: Appcolors.maincolor,
                size: 30, fontWeight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,top: 30),
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.mail,size: 19,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 0),
                        child:OnbordingText(text1: 'Your email ', color: Appcolors.black,
                          size: 15, fontWeight: FontWeight.normal,),
                      ),
                    ],),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 20),
                      child: EmailTextfomfield( fieldtext: 'Enter Email'
                        , controller: emailcontroller,),
                    ),
                    Row(children: [
                      Icon(Icons.lock,size: 19,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 0),
                        child:OnbordingText(text1: 'Password ', color: Appcolors.black,
                          size: 15, fontWeight: FontWeight.normal,),
                      ),
                    ],),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: PasswordTexFormField(fieldtext: 'pasword'
                        , controller: passwordcontroller,)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30,left: 100),
                      child:  OnbordingText(text1: 'forget password?', color: Appcolors.maincolor,
                        size: 15, fontWeight: FontWeight.normal,)
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 0,top: 50),
                        child: InkWell(
                          onTap: ()
                          async
                         {
                           await FirebaseAuth.instance.signInWithEmailAndPassword(
                               email: emailcontroller.text, password: passwordcontroller.text)
                               .then((onValue){
                                 isLoading=false;
                                 setState(() {

                                 });
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                           }).
                           onError((handleError,error){
                             isLoading=false;
                             setState(() {

                             });
                             print("error$error{error}");
                           });
                         },

                          child: LetsStartButton(height: 40, width: 300, text1: 'Login', size: 20, fontWeight: FontWeight.w600,
                            colortext: Appcolors.white, colorCont: Appcolors.maincolor,),
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 30,left: 50),
                        child:  Row(
                          children: [
                            OnbordingText(text1: 'Don\'t have a account?', color: Appcolors.black,
                              size: 15, fontWeight: FontWeight.normal,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                              },
                              child: OnbordingText(text1: ' Sign up', color: Appcolors.maincolor,
                                size: 15, fontWeight: FontWeight.normal,),
                            ),
                          ],
                        )
                    ),
                        
                  ],
                ),
              )
            ),
            
          ],
        ),
      ),
    );
  }
}

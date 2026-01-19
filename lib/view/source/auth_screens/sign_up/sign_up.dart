import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/email_textformfield/email_textfomfield.dart';
import '../../../components/onbording_text/button/lets_start_button.dart';
import '../../../components/onbording_text/onbording_text.dart';
import '../../../components/password_texformfield/password_tex_form_field.dart';
import '../../../utills/appcolors/appcolors.dart';
import '../../botom_navigation_bar/Home_screens/home_screen.dart';
import '../login_screen/lodin.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
final namecontroller=TextEditingController();
final  emailcontroller=TextEditingController();
final passwordcontroller=TextEditingController();
class _SignUpState extends State<SignUp> {
  bool isLoading=false;
  String text='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      appBar: AppBar(
          backgroundColor: Appcolors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: OnbordingText(text1: 'Create Account', color: Appcolors.black,

              size: 25, fontWeight: FontWeight.bold,),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(left: 30,top: 30),
            child:OnbordingText(text1: 'Sign up', color: Appcolors.maincolor,
              size: 30, fontWeight: FontWeight.bold,),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 50),
              child:Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25,),
                  child: Row(children: [
                    Icon(Icons.person,size: 19,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 0),
                      child:OnbordingText(text1: 'Your Name ', color: Appcolors.black,
                        size: 15, fontWeight: FontWeight.normal,),
                    ),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 20),
                  child: EmailTextfomfield( fieldtext: 'Enter Name'
                    , controller: namecontroller,),
                ),
              ],)
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10),
              child:Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(children: [
                    Icon(Icons.mail,size: 19,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 0),
                      child:OnbordingText(text1: 'Your email ', color: Appcolors.black,
                        size: 15, fontWeight: FontWeight.normal,),
                    ),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 20),
                  child: EmailTextfomfield( fieldtext: 'Enter Email'
                    , controller: emailcontroller,),
                ),
              ],)
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10),
              child:Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(children: [
                    Icon(Icons.lock,size: 19,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 0),
                      child:OnbordingText(text1: 'Password ', color: Appcolors.black,
                        size: 15, fontWeight: FontWeight.normal,),
                    ),
                  ],),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PasswordTexFormField(fieldtext: 'pasword'
                      , controller: passwordcontroller,)
                ),
              ],)
            ),

            //sign up button
            isLoading?CircularProgressIndicator():Padding(
                padding: const EdgeInsets.only(left: 30,top: 50),
                child: InkWell(
                  onTap: ()
                  async
                  {
                    isLoading=true;
                    setState(() {

                    });
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailcontroller.text,
                    password: passwordcontroller.text).then((onValue)async{
                      isLoading=false;
                      setState(() {

                      });
                      String userid=await FirebaseAuth.instance.currentUser!.uid;
                      await FirebaseFirestore.instance.collection('user').doc(userid).set({
                        'name':namecontroller.text,
                        'email':emailcontroller.text,
                        'id':userid,
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                }).onError((error,handleError){
                  isLoading=false;
                  setState(() {

                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('error:$text{error}',
                        ),
                        duration: Duration(seconds: 3),
                      )
                  );
                  //print('error:$text{error}'.toString());
                });

                  },
                  child: LetsStartButton(height: 40, width: 300, text1: 'Sign Up', size: 20, fontWeight: FontWeight.w600,
                    colortext: Appcolors.white, colorCont: Appcolors.maincolor,),
                )
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30,left: 90),
                child:  Row(
                  children: [
                    OnbordingText(text1: 'Already a user?', color: Appcolors.black,
                      size: 15, fontWeight: FontWeight.normal,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreens()));
                      },
                      child: OnbordingText(text1: ' Sign in', color: Appcolors.maincolor,
                        size: 15, fontWeight: FontWeight.normal,),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10,left: 160),
                child:  Row(
                  children: [
                    OnbordingText(text1: 'OR', color: Appcolors.black,
                      size: 25, fontWeight: FontWeight.w600,),

                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100,top: 5),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(backgroundImage: AssetImage('assets/signUp/facebook.png'),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(backgroundImage: AssetImage('assets/signUp/instagram.png'),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(backgroundImage: AssetImage('assets/signUp/twiter.png'),),
                ),
              ],),
            )

        ],),
      ),
    );
  }
}

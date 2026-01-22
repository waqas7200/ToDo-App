import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/source/auth_screens/login_screen/lodin.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';

import '../../../components/onbording_text/onbording_text.dart';
class SeetingAndProfile extends StatefulWidget {
  const SeetingAndProfile({super.key});

  @override
  State<SeetingAndProfile> createState() => _SeetingAndProfileState();
}

class _SeetingAndProfileState extends State<SeetingAndProfile> {
  String name='';
  String email='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  getdata()async{
   try{
     String uid=  FirebaseAuth.instance.currentUser!.uid;
     DocumentSnapshot userinformation=await FirebaseFirestore.instance.
     collection('todoapp').doc(uid).get();
     setState(() {
     name=userinformation['name'];
     email=userinformation['email'];
     });

   }
   catch(e){ print('Error fetching data: $e');}
  }
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
            padding: const EdgeInsets.only(top: 20,left: 20),
            child:  ListTile(
              leading: Icon(Icons.person),
              title: Row(
                spacing: 10,
                children: [
                  OnbordingText(text1: 'name :', color: Appcolors.black,
                      size: 20, fontWeight: FontWeight.bold),
                  OnbordingText(text1: name, color: Appcolors.black,
                      size: 16, fontWeight: FontWeight.normal)
                ],
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0,left: 20),
            child:   ListTile(
              leading: Icon(Icons.email),
              title: Row(
                spacing: 10,
                children: [
                  OnbordingText(text1: 'email :', color: Appcolors.black,
                      size: 20, fontWeight: FontWeight.bold),
                  OnbordingText(text1: email, color: Appcolors.black,
                      size: 16, fontWeight: FontWeight.normal)
                ],
              ),

            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 70,right: 70,top: 50),
              child: ElevatedButton(onPressed: (){
                showDialog(context: context,
                    builder: (context){
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnbordingText(text1: 'Are you shure to want logout!', color: Appcolors.black,
                            size: 16, fontWeight: FontWeight.bold),
                       Padding(
                         padding: const EdgeInsets.only(left: 25),
                         child: Row(children: [
                           TextButton(onPressed: (){
                             Navigator.pop(context);
                           }, child: OnbordingText(text1: 'cancel',
                               color: Appcolors.maincolor, size: 18, fontWeight: FontWeight.bold)),
                           TextButton(onPressed: ()async{
                             await FirebaseAuth.instance.signOut().then((onValue){
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreens()));
                             }).onError((error,handleError){});
                           }, child: OnbordingText(text1: 'Logout',
                               color: Colors.red, size: 18, fontWeight: FontWeight.bold)),

                         ],),
                       )
                    ],),
                  );
                    });
              }, child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Logout  '),
                  Icon(Icons.logout)
                ],
              ),)),
            )

            // TextButton(onPressed: ()async {
            //   await FirebaseAuth.instance.signOut().then((value) {
            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (con) => AuthScreens()));
            //   }).onError((errror,handleError){
            //
            //   });
            // }, child: Text('Logout'))



         // Card(child: Container(),)
        ],
      ),
    );
  }
}

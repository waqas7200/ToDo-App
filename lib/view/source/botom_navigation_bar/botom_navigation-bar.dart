import 'package:flutter/material.dart';
import 'package:todo_app/view/source/botom_navigation_bar/setting_and_profile/seeting_and_profile.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';

import 'Calander_screen/calander_screen.dart';
import 'Home_screens/home_screen.dart';
class BotomNavigation_bar extends StatefulWidget {
  const BotomNavigation_bar({super.key});

  @override
  State<BotomNavigation_bar> createState() => _BotomNavigation_barState();
}

class _BotomNavigation_barState extends State<BotomNavigation_bar> {
  int index=0;
  final screens=[
    HomeScreen(),
    CalanderScreen(),
    Text('df'),
    SeetingAndProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(index),
      backgroundColor: Appcolors.white,
     bottomNavigationBar: BottomNavigationBar(
       currentIndex: index,
         onTap:(value){
         index=value;
         setState(() {

         });
         },
         selectedItemColor: Appcolors.maincolor,
         unselectedItemColor: Colors.grey,
         items: [
       BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: ''),
       BottomNavigationBarItem(icon: Icon(Icons.date_range),label: ''),
       BottomNavigationBarItem(icon: Icon(Icons.insert_drive_file),label: ''),
       BottomNavigationBarItem(icon: Icon(Icons.settings_sharp),label: ''),

     ]),
    );
  }
}

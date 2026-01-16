import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/components/onbording_text/onbording_text.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';
import '../../../components/home/addtaskscustomfield/addtasksformfield/addtextformfield.dart';
import '../../../components/home/search_texformfield/search_texformfield.dart';
import '../home_screen.dart';
import 'package:intl/intl.dart';
class AddTasks extends StatefulWidget {
   AddTasks({super.key});


  @override
  State<AddTasks> createState() => _AddTasksState();
}
TextEditingController taskcontroller=TextEditingController();
TextEditingController workcontroller=TextEditingController();
TextEditingController addtaskcontroller=TextEditingController();

class _AddTasksState extends State<AddTasks> {
  DateTime? selectedate;
  TimeOfDay? selectedtime;

  List<Map<String,String>>list1=[];
  //add tasks functions
  void Add(){
    if(taskcontroller.text.isNotEmpty)
      {
        setState(() {
          list1.add({
            'task':taskcontroller.text,
             'date':selectedate==null?"":DateFormat('dd-MM-YY').format(selectedate!),
            'time':selectedtime==null?"":selectedtime!.format(context),
          });
          taskcontroller.clear();
          selectedtime=null;
          selectedate=null;
        });
      }
  }
  //delet function
  void Delete(int index)
  {
   setState(() {
     list1.removeAt(index);
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      appBar: AppBar(
        title: OnbordingText(text1:'Add task', color: Appcolors.maincolor,
            size: 20, fontWeight: FontWeight.w600),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: (){Navigator.pop(context);},
              child: OnbordingText(text1:'Cancel', color: Appcolors.litered,
                  size: 16, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
      body:Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Card(
                  child: SearchTexformfield(icon: Icons.fiber_manual_record_outlined,fieldtext: 'Add Tasks',
                    controller: taskcontroller,containercolor: Appcolors.liteblue,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: OnbordingText(text1:'Category', color: Appcolors.maincolor,
                    size: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: Card(
                  child: SearchTexformfield(icon: Icons.fiber_manual_record_outlined,fieldtext: 'Work',
                    controller: workcontroller,containercolor: Appcolors.liteblue,
                    suficon: Icons.keyboard_arrow_down_outlined,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: OnbordingText(text1:'Date', color: Appcolors.maincolor,
                    size: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10),
                  child:Row(
                    children: [
                      InkWell(
                        onTap: ()async{

                          DateTime? datePicked= await  showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate:DateTime.now() ,
                            lastDate: DateTime(2030),

                          );
                          if(selectedate!=null){
                            setState(() {
                              selectedate=datePicked;
                            });
                          }
                        },
                        child: Container(
                          height: 22,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/add_tasks/date.png'),
                            ),
                          ),
                        ),
                      ),
                      OnbordingText(text1: 'Set due date', color: Appcolors.black,
                          size: 13, fontWeight: FontWeight.normal),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 30,top: 15),
                  child:Row(
                    children: [
                      InkWell(
                        onTap:()async{
                          TimeOfDay? pickedTime= await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dial
                          );
                          if(selectedtime!=null){
                            setState(() {
                              selectedtime=pickedTime;
                            });
                          }
                        },
                        child: Container(
                          height: 22,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/add_tasks/time.png'),
                            ),
                          ),
                        ),
                      ),
                      OnbordingText(text1: 'Set Time', color: Appcolors.black,
                          size: 13, fontWeight: FontWeight.normal),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: OnbordingText(text1:'Reminder', color: Appcolors.maincolor,
                    size: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 30,top: 15),
                  child:Row(
                    children: [
                      InkWell(
                  
                        child:  Container(
                          height: 22,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/add_tasks/notification.png'),
                            ),
                          ),
                        ),
                      ),

                      OnbordingText(text1: 'Set Reminder', color: Appcolors.black,
                          size: 13, fontWeight: FontWeight.normal),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 20),
                child: OnbordingText(text1:'Notes', color: Appcolors.maincolor,
                    size: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: Card(
                    child:
                    Addtextformfield(fieldtext: 'write notes here',
                      controller:addtaskcontroller ,
                      suficon: Icons.keyboard_arrow_down_outlined,

                      height: 200,
                      containercolor: Appcolors.liteblue,
                    )
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                  child:SizedBox(
                      height: 300,
                      width: double.infinity,
                      child:ListView.builder(
                          itemCount: list1.length,
                          itemBuilder: (context,index){
                            return Card(child:
                            ListTile(
                              title: Text(
                                  "${list1[index]['task']}"
                              ),
                              subtitle: Text(
                                "date:${list1[index][selectedate]}  || time:${list1[index][selectedtime]}",style: TextStyle(color: Colors.black),
                              ),
                              trailing:TextButton(onPressed: ()=>Delete(index), child:Icon(Icons.delete),)

                            )
                            );
                          })
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 450,left: 250),
          child: Center(
            child: InkWell(
               onTap: ()async{
                 String id=DateTime.now().microsecond.toString();
                 String userid=FirebaseAuth.instance.currentUser!.uid;
                 await FirebaseFirestore.instance.collection('user').doc(userid)
                     .collection('insetdata').doc(id).set({});
               },
              child: CircleAvatar(
                backgroundColor: Appcolors.liteblue2,
                child: Icon(Icons.check,color: Appcolors.white,),),
            ),
          ),
        )

      ],)
    );
  }
}

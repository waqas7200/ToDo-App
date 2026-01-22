import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/components/onbording_text/onbording_text.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';
import '../../../../../model/home_model/home_model.dart';
import '../../../../components/home/addtaskscustomfield/addtasksformfield/addtextformfield.dart';
import '../../../../components/home/search_texformfield/search_texformfield.dart';
import '../home_screen.dart';
import 'package:intl/intl.dart';
class AddTasks extends StatefulWidget {
   AddTasks({super.key});


  @override
  State<AddTasks> createState() => _AddTasksState();
}
TextEditingController taskcontroller=TextEditingController();
TextEditingController workcontroller=TextEditingController();
TextEditingController notecontroller=TextEditingController();

class _AddTasksState extends State<AddTasks> {
  List<home>data=[
    home(image: 'assets/home/work.png', text: 'work', color: Appcolors.liteblue2),
    home(image: 'assets/home/profile.png', text: 'persnol', color: Appcolors.litered),
    home(image: 'assets/home/chart.png', text: 'shoping', color: Appcolors.liteyellow),
    home(image: 'assets/home/health.png', text: 'health', color: Appcolors.liteblue2),
  ];

  int selectedcard=-1;
  String? selectedcatagery="";
  Widget catagerycard(String title){
    return SizedBox(
      height: 55,
      child:InkWell(
        onTap: (){
          setState(() {
            selectedcatagery=title;
          });
          Navigator.pop(context);
        },
        child: Card(
          child: Row(children: [
            Text(title),
            Spacer(),
            selectedcatagery==title?Icon(Icons.check,size: 15,):SizedBox()
          ],),
        ),
      ),
    );
  }
  DateTime? selectedate;
  TimeOfDay? selectedtime;

  // List<Map<String,String>>list1=[];
  // //add tasks functions
  // void Add(){
  //   if(taskcontroller.text.isNotEmpty)
  //     {
  //       setState(() {
  //         list1.add({
  //           'task':taskcontroller.text,
  //            'date':selectedate==null?"":DateFormat('dd-MM-YY').format(selectedate!),
  //           'time':selectedtime==null?"":selectedtime!.format(context),
  //         });
  //         taskcontroller.clear();
  //         selectedtime=null;
  //         selectedate=null;
  //       });
  //     }
  // }
  // //delet function
  // void Delete(int index)
  // {
  //  setState(() {
  //    list1.removeAt(index);
  //  });
  // }
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
                padding: const EdgeInsets.only(left: 10,top: 10),
                child: SizedBox(
                  height: 90,
                  width: 335,
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                      itemCount: data.length,
                      itemBuilder:(context,index){

                        return Padding(
                            padding: const EdgeInsets.only(left: 5,top: 10),
                            child:InkWell(
                              onTap: (){
                                setState(() {
                                  selectedcard=index;
                                });
                              },
                              child: Card(
                                color: selectedcard==index?Appcolors.liteblue:Appcolors.white,
                                child:  Container(
                                height: 0,
                                width: 80,
                                decoration: BoxDecoration(
                                 // color: selectedcard==0?Appcolors.liteblue:Appcolors.white,
                                  borderRadius: BorderRadius.circular(13),

                                ),child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      height: 25,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(data[index].image.toString())),
                                      ),
                                    ),
                                  ),
                                  Text(data[index].text.toString(),style: TextStyle(color: data[index].color),)
                                ],
                              ),
                              ),),
                            )
                        );
                      } ),
                ),
              ),


           // date picker===================================
              //===========================================
              //==========================================
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
                          if(datePicked!=null){
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

              //Time picker=================================
              //===============================================
              //===============================================
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
                          if(pickedTime!=null){
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


              //reminder code
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



              //notes ka code
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
                      controller:notecontroller ,
                      suficon: Icons.keyboard_arrow_down_outlined,

                      height: 200,
                      containercolor: Appcolors.liteblue,
                    )
                ),
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 500,left: 0),
          child: Center(
            child: InkWell(
               onTap: ()async{
                 String id=DateTime.now().microsecond.toString();
                 String userid=FirebaseAuth.instance.currentUser!.uid;
                 await FirebaseFirestore.instance.collection('todoapp').doc(userid)
                     .collection('insertdata').doc(id).set({
                   'task':taskcontroller.text,
                   'category':selectedcard==0?'work':selectedcard==1?'persnol':selectedcard==2?'shoping':selectedcard==3?'Health':SizedBox(),
                   'time': selectedtime == null ? '' : selectedtime!.format(context),
                   'date': selectedate == null ? '' : DateFormat('dd-MM-yyyy').format(selectedate!),
                   'note':notecontroller.text,
                   'id':userid,
                 });
                 taskcontroller.clear();
                 notecontroller.clear();
                 Navigator.pop(context);
               },
              child: CircleAvatar(radius: 25,

                backgroundColor: Appcolors.liteblue2,
                child: Icon(Icons.check,color: Appcolors.white,size: 30,),),
            ),
          ),
        )

      ],)
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/components/onbording_text/onbording_text.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';

import '../../../../model/home_model/home_model.dart';
import '../../../components/home/search_texformfield/search_texformfield.dart';
import 'add_tasks/add_tasks.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
TextEditingController searchcontroller=TextEditingController();

List<home>data=[
  home(image: 'assets/home/work.png', text: 'work', color: Appcolors.liteblue2),
  home(image: 'assets/home/profile.png', text: 'persnol', color: Appcolors.litered),
  home(image: 'assets/home/chart.png', text: 'shoping', color: Appcolors.liteyellow),
  home(image: 'assets/home/health.png', text: 'health', color: Appcolors.liteblue2),
];

class _HomeScreenState extends State<HomeScreen> {
  String? userid;
  String? user;
String selected='';
/*
 selected='work'

 selected='personal'

 selecetd=''shopping

 selecetd='health'
* */
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
  getdata();
  }
  getdata()async{
    final user=await FirebaseAuth.instance.currentUser;
    if( user!=null){
      setState(() {
        userid=user.uid;
      });
    }
  }
  int selectedcatagery=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Appcolors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 5),
                  child: Card(
                    child: SearchTexformfield(icon: Icons.search,fieldtext: 'Search for Tasks, Events',
                      controller: searchcontroller,containercolor: Appcolors.liteblue,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10),
                  child: OnbordingText(text1: 'Categories', color: Appcolors.black, size: 20,
                      fontWeight: FontWeight.bold),
                ),


                //Grid vew builder code
                SizedBox(
                  height: 200,
                  width: 300,
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                      itemCount: data.length,
                      itemBuilder:(context,index){
                        return Padding(
                            padding: const EdgeInsets.only(left: 15,top: 10),
                            child:InkWell(
                              onTap: (){
                               // selectedcatagery=index;
                                setState(() {
                              selectedcatagery=index;
                              selected = data[index].text.toString();
                                });
                              },
                              child: Card(child:  Container(
                                height: 70,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: selectedcatagery==index?Appcolors.liteblue:null,
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


                //today task code & see all task code both are in one row
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20),
                  child: Row(children: [
                    OnbordingText(text1: 'Today’s task', color: Appcolors.black,
                        size: 20, fontWeight: FontWeight.bold),

                  //see all task
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddTasks()));
                        },
                        child: OnbordingText(text1: 'See all', color: Appcolors.liteblue2,
                            size: 15, fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],),
                ),

                //fetching code result here of adding tasks all data
                selected==''?

                Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                    child:SizedBox(
                        height: 300,

                        width: double.infinity,
                        child:userid==null?CircularProgressIndicator():StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                .collection('insertdata').snapshots(),
                            builder: (contex,snapshots){
                              if(snapshots.connectionState==ConnectionState.waiting){
                                return Center(child: CircularProgressIndicator());
                              }
                              if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                                return Center(child:
                                Text('No Data is avalibale',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                );

                              }

                              return ListView.builder(
                                  itemCount: snapshots.data!.docs.length,
                                  itemBuilder: (context,index){
                                    return Card(
                                      color: Appcolors.liteblue,
                                      // shadowColor: Colors.grey.shade400,
                                      child: ListTile(
                                        onLongPress: ()async{
                                          showDialog(context: context, builder:(BuildContext context){
                                            return AlertDialog(
                                              //  title: Text('Delete',style: TextStyle(color: Colors.red),),
                                                content:Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 4),
                                                      child: Text('Are you sure to want to delete it',
                                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold
                                                        ),),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [

                                                        TextButton(onPressed: (){
                                                          Navigator.pop(context);
                                                        }, child:Text('cancel',
                                                          style: TextStyle(color: Colors.blue),), ),
                                                        TextButton(onPressed: ()async{
                                                          await FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                                              .collection('insertdata').doc(snapshots.data!.docs[index].id).delete();
                                                          Navigator.pop(context);
                                                        }, child:Text('Delete',
                                                          style: TextStyle(color: Colors.red),), )
                                                      ],
                                                    )
                                                  ],
                                                )
                                            );
                                          });

                                        },
                                        onTap: ()async{

                                          Navigator.push(context, MaterialPageRoute(builder:
                                              (context)=>View(
                                            task: snapshots.data!.docs[index]['task'].toString()??"",
                                            date: snapshots.data!.docs[index]['date'].toString()??"",
                                            time:snapshots.data!.docs[index]['time'].toString()??"",
                                            note: snapshots.data!.docs[index]['note'].toString()??"",
                                            catagery:snapshots.data!.docs[index]['category'].toString() ,)));
                                        },
                                        title: Text(snapshots.data!.docs[index]['task'].toString()??""),
                                        subtitle: Text(snapshots.data!.docs[index]['date']??""),
                                        trailing: Text(snapshots.data!.docs[index]['time']??""),
                                      ),
                                    );
                                  }
                              );
                            })

                    )):
                selected=='work'?
                Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                    child:SizedBox(
                        height: 300,

                        width: double.infinity,
                        child:userid==null?CircularProgressIndicator():StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                .collection('insertdata').snapshots(),
                            builder: (contex,snapshots){
                              if(snapshots.connectionState==ConnectionState.waiting){
                                return Center(child: CircularProgressIndicator());
                              }
                              if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                                return Center(child:
                                Text('No Data is avalibale',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                );

                              }

                              return ListView.builder(
                                  itemCount: snapshots.data!.docs.length,
                                  itemBuilder: (context,index){
                                    return
                                      snapshots.data!.docs[index]['category'].toString()=='work'?

                                      Card(
                                      color: Appcolors.liteblue,
                                      // shadowColor: Colors.grey.shade400,
                                      child: ListTile(
                                        onLongPress: ()async{
                                          showDialog(context: context, builder:(BuildContext context){
                                            return AlertDialog(
                                              //  title: Text('Delete',style: TextStyle(color: Colors.red),),
                                                content:Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 4),
                                                      child: Text('Are you sure to want to delete it',
                                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold
                                                        ),),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [

                                                        TextButton(onPressed: (){
                                                          Navigator.pop(context);
                                                        }, child:Text('cancel',
                                                          style: TextStyle(color: Colors.blue),), ),
                                                        TextButton(onPressed: ()async{
                                                          await FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                                              .collection('insertdata').doc(snapshots.data!.docs[index].id).delete();
                                                          Navigator.pop(context);
                                                        }, child:Text('Delete',
                                                          style: TextStyle(color: Colors.red),), )
                                                      ],
                                                    )
                                                  ],
                                                )
                                            );
                                          });

                                        },
                                        onTap: ()async{

                                          Navigator.push(context, MaterialPageRoute(builder:
                                              (context)=>View(
                                            task: snapshots.data!.docs[index]['task'].toString()??"",
                                            date: snapshots.data!.docs[index]['date'].toString()??"",
                                            time:snapshots.data!.docs[index]['time'].toString()??"",
                                            note: snapshots.data!.docs[index]['note'].toString()??"",
                                            catagery:snapshots.data!.docs[index]['category'].toString() ,)));
                                        },
                                        title: Text(snapshots.data!.docs[index]['task'].toString()??""),
                                        subtitle: Text(snapshots.data!.docs[index]['date']??""),
                                        trailing: Text(snapshots.data!.docs[index]['time']??""),
                                      ),
                                    ):SizedBox();
                                  }
                              );
                            })

                    )):
                    selected=='persnol'?
                    Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                        child:SizedBox(
                            height: 300,

                            width: double.infinity,
                            child:userid==null?CircularProgressIndicator():StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                    .collection('insertdata').snapshots(),
                                builder: (contex,snapshots){
                                  if(snapshots.connectionState==ConnectionState.waiting){
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                                    return Center(child:
                                    Text('No Data is avalibale',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                    );

                                  }

                                  return ListView.builder(
                                      itemCount: snapshots.data!.docs.length,
                                      itemBuilder: (context,index){
                                        return
                                          snapshots.data!.docs[index]['category'].toString()=='persnol'?

                                          Card(
                                            color: Appcolors.liteblue,
                                            // shadowColor: Colors.grey.shade400,
                                            child: ListTile(
                                              onLongPress: ()async{
                                                showDialog(context: context, builder:(BuildContext context){
                                                  return AlertDialog(
                                                    //  title: Text('Delete',style: TextStyle(color: Colors.red),),
                                                      content:Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 4),
                                                            child: Text('Are you sure to want to delete it',
                                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold
                                                              ),),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [

                                                              TextButton(onPressed: (){
                                                                Navigator.pop(context);
                                                              }, child:Text('cancel',
                                                                style: TextStyle(color: Colors.blue),), ),
                                                              TextButton(onPressed: ()async{
                                                                await FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                                                    .collection('insertdata').doc(snapshots.data!.docs[index].id).
                                                                delete();
                                                                Navigator.pop(context);
                                                              }, child:Text('Delete',
                                                                style: TextStyle(color: Colors.red),), )
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                  );
                                                });

                                              },
                                              onTap: ()async{

                                                Navigator.push(context, MaterialPageRoute(builder:
                                                    (context)=>View(
                                                  task: snapshots.data!.docs[index]['task'].toString()??"",
                                                  date: snapshots.data!.docs[index]['date'].toString()??"",
                                                  time:snapshots.data!.docs[index]['time'].toString()??"",
                                                  note: snapshots.data!.docs[index]['note'].toString()??"",
                                                  catagery:snapshots.data!.docs[index]['category'].toString() ,)));
                                              },
                                              title: Text(snapshots.data!.docs[index]['task'].toString()??""),
                                              subtitle: Text(snapshots.data!.docs[index]['date']??""),
                                              trailing: Text(snapshots.data!.docs[index]['time']??""),
                                            ),
                                          ):SizedBox();
                                      }
                                  );
                                })

                        )):
                    selected=='shoping'?
                    Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                        child:SizedBox(
                            height: 300,

                            width: double.infinity,
                            child:userid==null?CircularProgressIndicator():StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                    .collection('insertdata').snapshots(),
                                builder: (contex,snapshots){
                                  if(snapshots.connectionState==ConnectionState.waiting){
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                                    return Center(child:
                                    Text('No Data is avalibale',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                    );

                                  }

                                  return ListView.builder(
                                      itemCount: snapshots.data!.docs.length,
                                      itemBuilder: (context,index){
                                        return
                                          snapshots.data!.docs[index]['category'].toString()=='shoping'?

                                          Card(
                                            color: Appcolors.liteblue,
                                            // shadowColor: Colors.grey.shade400,
                                            child: ListTile(
                                              onLongPress: ()async{
                                                showDialog(context: context, builder:(BuildContext context){
                                                  return AlertDialog(
                                                    //  title: Text('Delete',style: TextStyle(color: Colors.red),),
                                                      content:Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 4),
                                                            child: Text('Are you sure to want to delete it',
                                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold
                                                              ),),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [

                                                              TextButton(onPressed: (){
                                                                Navigator.pop(context);
                                                              }, child:Text('cancel',
                                                                style: TextStyle(color: Colors.blue),), ),
                                                              TextButton(onPressed: ()async{
                                                                await FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                                                    .collection('insertdata').doc(snapshots.data!.docs[index].id).
                                                                delete();
                                                                Navigator.pop(context);
                                                              }, child:Text('Delete',
                                                                style: TextStyle(color: Colors.red),), )
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                  );
                                                });

                                              },
                                              onTap: ()async{

                                                Navigator.push(context, MaterialPageRoute(builder:
                                                    (context)=>View(
                                                  task: snapshots.data!.docs[index]['task'].toString()??"",
                                                  date: snapshots.data!.docs[index]['date'].toString()??"",
                                                  time:snapshots.data!.docs[index]['time'].toString()??"",
                                                  note: snapshots.data!.docs[index]['note'].toString()??"",
                                                  catagery:snapshots.data!.docs[index]['category'].toString() ,)));
                                              },
                                              title: Text(snapshots.data!.docs[index]['task'].toString()??""),
                                              subtitle: Text(snapshots.data!.docs[index]['date']??""),
                                              trailing: Text(snapshots.data!.docs[index]['time']??""),
                                            ),
                                          ):SizedBox();
                                      }
                                  );
                                })

                        )):
                        selected=='Health'?
                        Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                            child:SizedBox(
                                height: 300,

                                width: double.infinity,
                                child:userid==null?CircularProgressIndicator():StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                        .collection('insertdata').snapshots(),
                                    builder: (contex,snapshots){
                                      if(snapshots.connectionState==ConnectionState.waiting){
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                                        return Center(child:
                                        Text('No Data is avalibale',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                        );

                                      }

                                      return ListView.builder(
                                          itemCount: snapshots.data!.docs.length,
                                          itemBuilder: (context,index){
                                            return
                                              snapshots.data!.docs[index]['category'].toString()=='Health'?

                                              Card(
                                                color: Appcolors.liteblue,
                                                // shadowColor: Colors.grey.shade400,
                                                child: ListTile(
                                                  onLongPress: ()async{
                                                    showDialog(context: context, builder:(BuildContext context){
                                                      return AlertDialog(
                                                        //  title: Text('Delete',style: TextStyle(color: Colors.red),),
                                                          content:Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 4),
                                                                child: Text('Are you sure to want to delete it',
                                                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold
                                                                  ),),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [

                                                                  TextButton(onPressed: (){
                                                                    Navigator.pop(context);
                                                                  }, child:Text('cancel',
                                                                    style: TextStyle(color: Colors.blue),), ),
                                                                  TextButton(onPressed: ()async{
                                                                    await FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                                                        .collection('insertdata').doc(snapshots.data!.docs[index].id).
                                                                    delete();
                                                                    Navigator.pop(context);
                                                                  }, child:Text('Delete',
                                                                    style: TextStyle(color: Colors.red),), )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                      );
                                                    });

                                                  },
                                                  onTap: ()async{

                                                    Navigator.push(context, MaterialPageRoute(builder:
                                                        (context)=>View(
                                                      task: snapshots.data!.docs[index]['task'].toString()??"",
                                                      date: snapshots.data!.docs[index]['date'].toString()??"",
                                                      time:snapshots.data!.docs[index]['time'].toString()??"",
                                                      note: snapshots.data!.docs[index]['note'].toString()??"",
                                                      catagery:snapshots.data!.docs[index]['category'].toString() ,)));
                                                  },
                                                  title: Text(snapshots.data!.docs[index]['task'].toString()??""),
                                                  subtitle: Text(snapshots.data!.docs[index]['date']??""),
                                                  trailing: Text(snapshots.data!.docs[index]['time']??""),
                                                ),
                                              ):SizedBox();
                                          }
                                      );
                                    })

                            ))
                :Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                            child:SizedBox(
                                height: 300,

                                width: double.infinity,
                                child:userid==null?CircularProgressIndicator():StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                        .collection('insertdata').snapshots(),
                                    builder: (contex,snapshots){
                                      if(snapshots.connectionState==ConnectionState.waiting){
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                                        return Center(child:
                                        Text('No Data is avalibale',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                        );

                                      }

                                      return ListView.builder(
                                          itemCount: snapshots.data!.docs.length,
                                          itemBuilder: (context,index){
                                            return
                                              snapshots.data!.docs[index]['category'].toString()=='Health'?

                                              Card(
                                                color: Appcolors.liteblue,
                                                // shadowColor: Colors.grey.shade400,
                                                child: ListTile(
                                                  onLongPress: ()async{
                                                    showDialog(context: context, builder:(BuildContext context){
                                                      return AlertDialog(
                                                        //  title: Text('Delete',style: TextStyle(color: Colors.red),),
                                                          content:Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 4),
                                                                child: Text('Are you sure to want to delete it',
                                                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold
                                                                  ),),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [

                                                                  TextButton(onPressed: (){
                                                                    Navigator.pop(context);
                                                                  }, child:Text('cancel',
                                                                    style: TextStyle(color: Colors.blue),), ),
                                                                  TextButton(onPressed: ()async{
                                                                    await FirebaseFirestore.instance.collection('todoapp').doc(userid)
                                                                        .collection('insertdata').doc(snapshots.data!.docs[index].id).
                                                                    delete();
                                                                    Navigator.pop(context);
                                                                  }, child:Text('Delete',
                                                                    style: TextStyle(color: Colors.red),), )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                      );
                                                    });

                                                  },
                                                  onTap: ()async{

                                                    Navigator.push(context, MaterialPageRoute(builder:
                                                        (context)=>View(
                                                      task: snapshots.data!.docs[index]['task'].toString()??"",
                                                      date: snapshots.data!.docs[index]['date'].toString()??"",
                                                      time:snapshots.data!.docs[index]['time'].toString()??"",
                                                      note: snapshots.data!.docs[index]['note'].toString()??"",
                                                      catagery:snapshots.data!.docs[index]['category'].toString() ,)));
                                                  },
                                                  title: Text(snapshots.data!.docs[index]['task'].toString()??""),
                                                  subtitle: Text(snapshots.data!.docs[index]['date']??""),
                                                  trailing: Text(snapshots.data!.docs[index]['time']??""),
                                                ),
                                              ):SizedBox();
                                          }
                                      );
                                    })

                            )),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 570,right: 0),
            child: Center(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTasks()));
                },
                child: CircleAvatar(backgroundColor: Appcolors.maincolor,
                  radius: 25,child: Icon(Icons.add,color: Appcolors.white,),),
              ),
            ),
          )
        ],
      )
    );
  }
}


class View extends StatelessWidget {
  final task;
  final time;
  final date;
  final note;
  final catagery;
  View({super.key,required this.task,required this.date,required this.time,required this.note,  this.catagery});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          width: 500,
          child: Card(
            color: Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //task name======================================
                Padding(
                  padding: const EdgeInsets.only(left: 50,top: 50,),
                  child: Row(
                    children: [
                      Text('Task name : ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(task,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),


                //task date========================================
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 50),
                  child:  Row(
                    children: [
                      Text('Date : ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(date,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),

                //task time======================================
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 50),
                  child:   Row(
                    children: [
                      Text('Time : ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(time,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),

                //task catagery===============================
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 50),
                  child:   Row(
                    children: [
                      Text('catagery :$catagery',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      //Text(catagery,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),

                //task notes====================================
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 50),
                  child:   Row(
                    children: [
                      Text('Notes : ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(note,softWrap: true,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      )
    );
  }
}

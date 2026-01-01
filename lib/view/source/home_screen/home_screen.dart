import 'package:flutter/material.dart';
import 'package:todo_app/view/components/onbording_text/onbording_text.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';

import '../../../model/home_model/home_model.dart';
import '../../components/home/search_texformfield/search_texformfield.dart';
import 'add_tasks/add_tasks.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
TextEditingController searchcontroller=TextEditingController();
List<String>list1=[

];
List<home>data=[
  home(image: 'assets/home/work.png', text: 'work', color: Appcolors.liteblue2),
  home(image: 'assets/home/profile.png', text: 'persnol', color: Appcolors.litered),
  home(image: 'assets/home/chart.png', text: 'shoping', color: Appcolors.liteyellow),
  home(image: 'assets/home/health.png', text: 'health', color: Appcolors.liteblue2),
];

class _HomeScreenState extends State<HomeScreen> {
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
                SizedBox(
                  height: 200,
                  width: 300,
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                      itemCount: data.length,
                      itemBuilder:(context,index){
                        return Padding(
                            padding: const EdgeInsets.only(left: 15,top: 10),
                            child:Card(child:  Container(
                              height: 70,
                              width: 160,
                              decoration: BoxDecoration(
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
                            ),)
                        );
                      } ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20),
                  child: Row(children: [
                    OnbordingText(text1: 'Today’s task', color: Appcolors.black,
                        size: 20, fontWeight: FontWeight.bold),
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: OnbordingText(text1: 'See all', color: Appcolors.liteblue2,
                          size: 15, fontWeight: FontWeight.bold),
                    ),
                  ],),
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
                                title: Text(list1[index]),

                              )
                              );
                            })
                    )),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 570),
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

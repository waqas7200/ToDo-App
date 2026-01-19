import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/view/utills/appcolors/appcolors.dart';
class CalanderScreen extends StatefulWidget {
  const CalanderScreen({super.key});

  @override
  State<CalanderScreen> createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: SizedBox(
              height: 350,
              child: Card(
                color: Colors.green.shade50,
                child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2000),
                    lastDay: DateTime.now()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

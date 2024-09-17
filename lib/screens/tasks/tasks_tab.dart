import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoo/models/tasks_model.dart';
import 'package:todoo/screens/tasks/task_item.dart';
import 'package:todoo/shared/network/firebase/firebase_manager.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: Colors.blueGrey,
          dayColor: Colors.teal[200],
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.redAccent[100],
          dotsColor: Color(0xFF333A47),
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseManager.getTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              }
              List<TaskModel> tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              print(tasks.length);
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]);
                },
                itemCount: tasks.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

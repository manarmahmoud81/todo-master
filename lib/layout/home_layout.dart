import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoo/screens/settings/setting_tab.dart';
import 'package:todoo/screens/tasks/add_task_bottom_sheet.dart';
import 'package:todoo/screens/tasks/tasks_tab.dart';
import 'package:todoo/shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final user = FirebaseAuth.instance.currentUser!;
  int index = 0;
  List<Widget> tabs = [TasksTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: mintGreen,
      appBar: AppBar(
        title: Text("ToDo List"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showAddTaskBottomSheet();
        },
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.white),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.list,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: tabs[index],
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}

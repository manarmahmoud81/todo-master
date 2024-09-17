import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoo/models/tasks_model.dart';
import 'package:todoo/shared/network/firebase/firebase_manager.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text("Task Title"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              label: Text("Task description"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Select Data",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          SizedBox(
            height: 9,
          ),
          InkWell(
            onTap: () {
              selectData();
            },
            child: Text(
              selectedDate.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              TaskModel task = TaskModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  date:
                      DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
              FirebaseManager.addTask(task);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Successfully"),
                    content: Text("Tasks Add To Firebase"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Thanks"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              "Add Task",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  selectData() async {
    DateTime? chosenData = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenData == null) {
      return;
    }
    selectedDate = chosenData;
    setState(() {});
  }
}

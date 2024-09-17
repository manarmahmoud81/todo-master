import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoo/models/tasks_model.dart';
import 'package:todoo/shared/network/firebase/firebase_manager.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task});

  final TaskModel task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.task.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'To Do List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(bottom: 36, top: 16, left: 16, right: 16),
          margin:
              const EdgeInsets.only(top: 20, bottom: 50, left: 20, right: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(18),
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Task',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50.h,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Edit Task",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Edit Task",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  selectDate();
                },
                child: Text(
                  'Selected date',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onError),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                selectedDate.toString().substring(0, 10),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () {
                    FirebaseManager.updateTask(TaskModel(
                        date: selectedDate.millisecondsSinceEpoch,
                        description: descriptionController.text,
                        title: titleController.text,
                        id: widget.task.id,
                        isDone: widget.task.isDone));
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
          const Duration(days: 365),
        ));
    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    setState(() {});
  }
}

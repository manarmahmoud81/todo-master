import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoo/models/tasks_model.dart';
import 'package:todoo/screens/tasks/edit_task.dart';
import 'package:todoo/shared/network/firebase/firebase_manager.dart';
import 'package:todoo/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.transparent),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              FirebaseManager.deleteTask(task.id);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditTaskPage(
                          task: task,
                        )),
              );
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.blue)),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title ?? '+++',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    task.description ?? '++++',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  task.isDone = true;
                  FirebaseManager.updateTask(task);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                      color: task.isDone ? Colors.green : primary,
                      borderRadius: BorderRadius.circular(12)),
                  child: task.isDone
                      ? Text(
                          "Done!",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      : Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoo/models/tasks_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromjson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addTask(TaskModel task) {
    CollectionReference collection = getCollection();
    var doc = collection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    return getCollection()
        .orderBy('date', descending: true)
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId) {
    return getCollection().doc(taskId).delete();
  }

  static void updateTask(TaskModel model) {
    getCollection().doc(model.id).update(model.toJson());
  }
}

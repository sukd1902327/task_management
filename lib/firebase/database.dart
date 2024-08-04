import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vita_app/models/get_model.dart';
import 'package:vita_app/models/tasks_cmplt_model.dart';
import 'package:vita_app/models/tasks_model.dart';
import 'package:vita_app/models/user_model.dart';

class DatabaseService {

  final FirebaseFirestore db = FirebaseFirestore.instance;
  //assign user id from firebase to the uid variable
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final EventModel eventController = Get.find();

  //create user information data
  Future setUserData(UserModel userModel) async {
    await db.collection('users').doc(uid).set(userModel.toFirestore());
  }

  //create task information data
  Future setTaskData(TasksModel tasksModel) async {
    await db.collection('tasks').doc().set(tasksModel.toFirestore());
    getTasksLength();
  }

  //create completed task information data
  Future setTaskCmpltdData(TaskCmpltdModel tasksCmpModel) async {
    await db.collection('tasks_completed').doc().set(tasksCmpModel.toFirestore());
    getTasksCmpltdLength();
  }

  //update checkBox task data
  Future checkBoxChanged(bool? value, String index, TaskCmpltdModel tasksCmpModel) async {
    await db.collection('tasks').doc(index).update({'isDone': value});
    if (value == true) {
      setTaskCmpltdData(tasksCmpModel);
      getTasksLength();
    }
  }

  //update note of a single task
  Future updateNote(String index, String newNote) async {
    await db.collection('tasks').doc(index).update({'note': newNote});
  }

  //delete a single task data
  Future deleteTask(String docID, DateTime date) async {
    await db.collection('tasks').doc(docID).delete();
    eventController.deleteEvent(date);
    getTasksLength();
  }

  //delete a single completed task data
  Future deleteTaskCmpltd(String docID) async {
    await db.collection('tasks_completed').doc(docID).delete();
    getTasksCmpltdLength();
  }

  //get task data and filter by categ
  Stream<QuerySnapshot<Object?>> filterBy(String? categ) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = db.collection('tasks').where('userId', isEqualTo: uid)
      .where('categ', isEqualTo: categ).orderBy('priority').snapshots();
    return snapshots;
  }

  //get all task data
  Stream<QuerySnapshot<Object?>> getTaskData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = db.collection('tasks')
      .where('userId', isEqualTo: uid).orderBy('priority').snapshots();
    return snapshots;
  }

  //get completed task data
  Stream<QuerySnapshot<Object?>> getTaskCmpltdData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = db.collection('tasks_completed').where('userId', isEqualTo: uid).snapshots();
    return snapshots;
  }

  //get task data length
  Future getTasksLength() async {
    final AggregateQuerySnapshot docs = await db.collection('tasks').where('userId', isEqualTo: uid).count().get();
    await db.collection('users').doc(uid).update({'pendingTask': docs.count});
  }

  //get completed task data length
  Future getTasksCmpltdLength() async {
    final AggregateQuerySnapshot docs = await db.collection('tasks_completed').where('userId', isEqualTo: uid).count().get();
    await db.collection('users').doc(uid).update({'completedTask': docs.count});
  }

  //get current user info stream
  Stream<UserModel> get currentUserData {
    return db.collection('users').doc(uid).snapshots().map(
      (snapshot) => UserModel.fromFirestore(snapshot.data() as Map<String, dynamic>)
    );
  }

}
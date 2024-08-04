import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vita_app/firebase/database.dart';
import 'package:vita_app/widgets/todo_tile.dart';

//this class used to search for specific task
class TaskSearch extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon(Icons.close)
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null), 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').where('userId', isEqualTo: uid).snapshots(), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        else {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data?.docs[index].data() as Map<String, dynamic>;
              if(query.isEmpty){
                return ToDoTile(
                  titleName: doc['title'], 
                  categoryName: doc['categ'],
                  taskCompleted: doc['isDone'], 
                  priority: doc['priority'],
                  notes: doc['note'],
                  onDelete: () => DatabaseService().deleteTask(doc[index].id, DateTime.now()),
                );
              }
              if(doc['title'].toString().toLowerCase().startsWith(query.toLowerCase())) {
                return ToDoTile(
                  titleName: doc['title'], 
                  categoryName: doc['categ'],
                  taskCompleted: doc['isDone'], 
                  priority: doc['priority'],
                  notes: doc['note'],
                  onDelete: () => DatabaseService().deleteTask(doc[index].id, DateTime.now()),
                );
              }
              return null;
            }
          );
        }
      }
    );
  }


}
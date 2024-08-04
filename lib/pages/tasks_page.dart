import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/firebase/database.dart';
import 'package:vita_app/pages/settings_page.dart';
import 'package:vita_app/widgets/todo_tile.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), 
            onPressed: () => Get.to(() => const SettingsPage()),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().getTaskCmpltdData(), 
        builder: (context, snapshot) {
            if (snapshot.hasData) {
              var documents = snapshot.data!.docs;
              if (documents.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        'Tasks Completed', 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          //here we called the custom ToDoTile class we created in widgets folder
                          return ToDoTile(
                            titleName: documents[index]['title'], 
                            categoryName: documents[index]['categ'],
                            taskCompleted: documents[index]['isDone'], 
                            priority: 0,
                            notes: documents[index]['note'],
                            onDelete: () => DatabaseService().deleteTaskCmpltd(documents[index].id),
                          );
                        }
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No task completed'));
              }
            }
            //if there's an error occurs
            else if (snapshot.hasError) {
              return const Center(
                child: AlertDialog(
                  icon: Icon(Icons.warning, color: Colors.amber, size: 30,),
                  title: Text('Check your network connection!'),
                ),
              );
            }
          //loading indicator will be shown until connection to database is done
          return const Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}

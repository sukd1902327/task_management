
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/firebase/database.dart';
import 'package:vita_app/models/get_model.dart';
import 'package:vita_app/models/tasks_cmplt_model.dart';
import 'package:vita_app/widgets/todo_tile.dart';
import 'filter_tile.dart';

class StreamTaskBuilder extends StatefulWidget {
  const StreamTaskBuilder({super.key,});

  @override
  State<StreamTaskBuilder> createState() => _StreamTaskBuilderState();
}

final CategoryModel categController = Get.find();

class _StreamTaskBuilderState extends State<StreamTaskBuilder> {
  late Stream<QuerySnapshot> stream1;
  late Stream<QuerySnapshot> stream2;
  final userID = FirebaseAuth.instance.currentUser!.uid;
  final txtController = TextEditingController();
  String? categ = categController.selectedCategory;

  @override
  void initState() {
    super.initState();
    stream1 = DatabaseService().getTaskData();
    stream2 = DatabaseService().filterBy(categ);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => showBoxDialog(),
              child: SizedBox(
                height: 40,
                child: Image.asset('assets/images/addCateg.png')
              ),
            ),
            FilterTile(categName: 'All', onTap: () {
              categController.setCategory(null);
              setState(() {
                categ = null;
              });
            }),
            Expanded(
              child: SizedBox(
                height: 50,
                child: GetBuilder<CategoryModel>(
                  init: CategoryModel(),
                  builder: (controller) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.dropdownItems.length,
                      itemBuilder: (context, index) {
                        String categName = controller.dropdownItems[index].value.toString();
                        return FilterTile(
                          categName: categName,
                          onTap: () {
                            controller.setCategory(categName);
                            setState(() {
                              categ = categName;
                              stream2 = DatabaseService().filterBy(categName);
                            });
                          },
                        );
                      }
                    );
                  }
                ),
              ),
            ),
          ],
        ),
        categ == null
        ? StreamBuilder<QuerySnapshot>(
          stream: stream1, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildListView(snapshot.data);
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
        )
        : StreamBuilder<QuerySnapshot>(
          stream: stream2, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildListView(snapshot.data);
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
      ],
    );
  }

  Widget buildListView(QuerySnapshot? snapshot){
    var documents = snapshot!.docs;
    if (documents.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            TaskCmpltdModel tasksCmpModel = TaskCmpltdModel(
              userId: userID, 
              title: documents[index]['title'], 
              categ: documents[index]['categ'], 
              isDone: true, 
              notes: documents[index]['note']
            );
            //here we called the custom ToDoTile class we created in widgets folder
            return ToDoTile(
              titleName: documents[index]['title'], 
              categoryName: documents[index]['categ'],
              taskCompleted: documents[index]['isDone'], 
              priority: documents[index]['priority'],
              notes: documents[index]['note'],
              onChanged: (val) => DatabaseService().checkBoxChanged(val, documents[index].id, tasksCmpModel),
              onDelete: () => DatabaseService().deleteTask(documents[index].id, DateTime.parse(documents[index]['date'])),
              docID: documents[index].id,
              date: documents[index]['date'],
              time: documents[index]['time'],
            );
          }
        ),
      );
    } else {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/noTask.png', height: 230,),
              const SizedBox(height: 5,),
              const Text(
                'No tasks available\nClick + to create new task.',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    }
  }

  void showBoxDialog(){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green[50],
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Add new category'),
          content: SizedBox(
            width: 200,
            child: TextField(
              controller: txtController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                txtController.text == ''
                ? null
                : setState(() {
                  categController.addCategory(txtController.text);
                });
                Get.back();
              },
              child: const Text('Save'),
            ),
          ]
        );
      }
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/firebase/database.dart';
import 'package:vita_app/models/get_model.dart';
import 'package:vita_app/models/tasks_model.dart';
import 'package:vita_app/pages/home/stream_tasks.dart';
import 'package:vita_app/pages/settings_page.dart';
import 'package:vita_app/widgets/dialog_box.dart';
import 'package:vita_app/widgets/snackbar.dart';
import 'package:vita_app/widgets/task_search.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _txtController = TextEditingController();
  final _priorityController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final userID = FirebaseAuth.instance.currentUser!.uid;
  final CategoryModel categController = Get.put(CategoryModel());
  final EventModel eventController = Get.put(EventModel());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar shows at the top of the screen
      appBar: AppBar(
        elevation: 0,
        title: const Text('Home Page'),
        actions: [
          //search icon
          IconButton(
            icon: const Icon(Icons.search), 
            onPressed: () => showSearch(context: context, delegate: TaskSearch())
          ),
          //option icon
          IconButton(
            icon: const Icon(Icons.settings), 
            onPressed: () => Get.to(() => const SettingsPage()),
          ),
        ],
      ),
      //we called createNewTask function that we created below the code
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(context),
        child: const Icon(Icons.add),
      ),
      //we called StreamTaskBuilder that we created in home folder
      body: const StreamTaskBuilder(),
    );
  }

  //this is the function to create a new task, we just called it above
  void createNewTask(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) {
        //show our custom dialogBox we created in widgets folder
        return DialogBox(
          formKey: _formKey,
          titleController: _txtController,
          priorityController: _priorityController,
          notesController: _notesController,
          onSave: () {
            final isValid = _formKey.currentState!.validate();
            //if the fields are validated create the task
            if(isValid) {
              eventController.addEvent(
                _txtController.text,
                _notesController.text,
                false,
                eventController.time.hour,
                eventController.time.minute,
              );
              //assign the task model to the data given by the user
              TasksModel tasksModel = TasksModel(
                userId: userID, 
                title: _txtController.text, 
                categ: categController.selectedCategory!, 
                notes: _notesController.text, 
                priority: int.parse(_priorityController.text), 
                isDone: false,
                date: eventController.date.toString().split(' ')[0],
                time: eventController.time.format(context).toString(),
              );
              //call setTaskData from database service and pass task model to it
              DatabaseService().setTaskData(tasksModel);
              //clear all the controllers
              _txtController.clear();
              _priorityController.clear();
              _notesController.clear();
              categController.setCategory(null);
              //hide the dialog box
              Get.back();
              mySnackbar('Success', 'A new task is added successfully', Colors.green);
            } 
          }
        );
      }
    );
  }

}
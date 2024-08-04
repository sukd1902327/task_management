import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/firebase/database.dart';
import 'package:vita_app/widgets/button.dart';
import 'package:vita_app/widgets/input_field.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    super.key, 
    required this.notes, 
    required this.title,
    required this.categ,
    required this.docID,
    required this.date,
    required this.time,
  });

  final String title, notes, categ, docID;
  final String? date, time;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController? noteController = TextEditingController(text: widget.notes);
    
    //this function is used to show the bottom sheet
    //in order to edit the task notes
    void showNoteEdit() {
      Get.bottomSheet(
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20), )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                InputField(
                  obs: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: noteController,
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 120,
                  child: Button(
                    text: 'Save', 
                    onPressed: () {
                      DatabaseService().updateNote(widget.docID, noteController.text); 
                      setState(() {});
                      Get.back();
                    }
                  ),
                )
              ],
            ),
          ),
        )
      );
    }

    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.05,),
            Container(
              width: width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            //here's the title of the task
                            widget.title,
                            maxLines: 3,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ),
                        widget.date == null
                        ? const Text('')
                        : Text(widget.date!, style: TextStyle(color: Colors.grey[600]),),
                      ],
                    ),
                    Text(widget.categ, style: TextStyle(color: Colors.grey[600]),),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          //if the note is empty the message 'No notes' will be displayed
                          child: widget.notes == ''
                            ? Text('No notes', style: TextStyle(color: Colors.grey[600]),)
                            : Text(widget.notes),
                          //otherwise, the notes will be displayed
                        ),
                        IconButton(
                          //now we called the function we created above 'showNoteEdit'
                          onPressed: () => showNoteEdit(), 
                          icon: const Icon(Icons.edit, color: Colors.blue,)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}
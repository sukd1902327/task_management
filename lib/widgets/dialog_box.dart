// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/models/get_model.dart';
import 'package:vita_app/widgets/dropdown_form.dart';

class DialogBox extends StatelessWidget {

  DialogBox({
    super.key, 
    this.titleController, 
    this.priorityController,
    this.notesController,
    required this.onSave,
    required this.formKey,
  });

  TextEditingController? titleController;
  TextEditingController? notesController;
  TextEditingController? priorityController;
  VoidCallback onSave;
  GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {

    EventModel controller = Get.put(EventModel());

    void chooseData() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.date,
        firstDate: controller.date,
        lastDate: DateTime(2030),
      );
      if (pickedDate != null) {
        controller.setDate(pickedDate);
      }
    }

    void chooseTime() async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: controller.time,
      );
      if (pickedTime != null) {
        controller.setTime(pickedTime);
      }
    }

    return AlertDialog(
      backgroundColor: Colors.green[50],
      actionsAlignment: MainAxisAlignment.center,
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //task title field
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: titleController,
                  validator: (value) => value == '' ? '*' : null,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    ),
                    hintText: 'Add a new task',
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              //task note field
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    ),
                    hintText: 'Add notes',
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const DropdownFrom(),
              const SizedBox(height: 10,),
              Row(
                children: [
                  //task priority field
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller: priorityController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == '' ? '*' : null,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)
                        ),
                        hintText: 'Priority',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  IconButton(
                    icon: const Icon(Icons.date_range, color: Colors.green, size: 32,),
                    onPressed: () => chooseData(),
                  ),
                  const SizedBox(width: 5,),
                  IconButton(
                    icon: const Icon(Icons.more_time, color: Colors.green, size: 32,),
                    onPressed: () => chooseTime(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
        const SizedBox(width: 5,),
        ElevatedButton(
          onPressed: (() => Get.back()),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
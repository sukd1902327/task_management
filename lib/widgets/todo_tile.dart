// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/pages/task_details.dart';

class ToDoTile extends StatelessWidget {
  final String titleName, categoryName, notes;
  final String? docID, date, time;
  final int priority;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  void Function()? onDelete;

  ToDoTile({
    super.key, 
    required this.titleName, 
    required this.categoryName, 
    required this.priority, 
    required this.notes, 
    required this.taskCompleted,
    this.date,
    this.time,
    this.docID,
    this.onChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        taskCompleted == false
        ? Get.to(() => TaskDetails(
            title: titleName, 
            notes: notes, 
            categ: categoryName,
            docID: docID.toString(),
            date: date,
            time: time,
          ))
        : null;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
        child: Container(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          decoration: BoxDecoration(
            color: Colors.green[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted, 
                onChanged: onChanged, 
                activeColor: Colors.black,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      titleName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none ,
                      ),
                    ),
                  ),
                  Text(
                    categoryName, 
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700]
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text('$priority', style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                  ),),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    onPressed: onDelete,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
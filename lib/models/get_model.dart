
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:get/get.dart';

class CategoryModel extends GetxController {

  String? selectedCategory;

  List<DropdownMenuItem<String>> dropdownItems =  [
    DropdownMenuItem(value: 'work', child: Text('work')),
    DropdownMenuItem(value: 'school', child: Text('school')),
    DropdownMenuItem(value: 'personal', child: Text('personal')),
    DropdownMenuItem(value: 'birthday', child: Text('birthday')),
  ];

  void addCategory(String categName) {
    dropdownItems.add(
      DropdownMenuItem(value: categName, child: Text(categName)),
    );
    update();
  }

  deleteCategory(DropdownMenuItem<String> categValue){
    dropdownItems.remove(categValue);
    update();
  }

  void setCategory(String? name) {
    selectedCategory = name;
    update();
  }

}


class EventModel extends GetxController {

  List<CleanCalendarEvent>? selectedEvent;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Map<DateTime, List<CleanCalendarEvent>> events = {};

  void addEvent(String summary, String description, bool isDone, int hour, int min){
    events.addAll(
      {
      date: [
        CleanCalendarEvent(
          summary, 
          description: description,
          isDone: isDone,
          startTime: DateTime(date.year, date.month, date.day, hour, min), 
          endTime: date.add( Duration(hours: hour+2, minutes: min))),
        ]
      }
    );
    update();
  }

  void deleteEvent(DateTime eventDate){
    events.remove(eventDate);
    update();
  }

  void handleDate(DateTime newDate){
    date = newDate;
    selectedEvent = events[date] ?? [];
    update();
  }

  void setDate(DateTime newDate){
    date = newDate;
    update();
  }

  void setTime(TimeOfDay newTime){
    time = newTime;
    update();
  }

}

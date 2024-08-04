import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:vita_app/models/get_model.dart';
import 'package:vita_app/pages/settings_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

EventModel controller = Get.put(EventModel());

class _CalendarPageState extends State<CalendarPage> {

  @override
  void initState() {
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    controller.handleDate(today);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), 
            onPressed: () => Get.to(() => const SettingsPage()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Calendar(
          events: controller.events,
          todayButtonText: '',
          isExpanded: true,
          selectedColor: Colors.blue,
          todayColor: Colors.red,
          eventColor: Colors.green,
          eventDoneColor: Colors.amber,
          dayOfWeekStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
          onDateSelected: (date) => controller.handleDate(date),
        ),
      ),
    );
  }
}
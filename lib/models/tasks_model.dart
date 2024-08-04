
class TasksModel {

  TasksModel({
    required this.userId,
    required this.title,
    required this.categ,
    required this.notes,
    required this.priority,
    required this.isDone,
    required this.date,
    required this.time,
  });

  String? userId, title, categ, notes, date, time;
  int? priority;
  bool? isDone;

  //to save data to cloud firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'categ': categ,
      'priority': priority,
      'note': notes,
      'isDone': isDone,
      'date': date,
      'time': time,
    };
  }

  //to fetch data from cloud firestore
  factory TasksModel.fromFirestore(Map<String, dynamic> map) {
    return TasksModel(
      userId: map['userId'],
      title: map['title'],
      categ: map['categ'],
      priority: map['priority'],
      notes: map['notes'],
      isDone: map['isDone'],
      date: map['date'],
      time: map['time'],
    );
  }

}

class TaskCmpltdModel {

  TaskCmpltdModel({
    required this.userId,
    required this.title,
    required this.categ,
    required this.isDone,
    required this.notes,
  });

  String? userId, title, categ, notes;
  bool? isDone;

  //to save data to cloud firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'categ': categ,
      'note': notes,
      'isDone': isDone,
    };
  }

  //to fetch data from cloud firestore
  factory TaskCmpltdModel.fromFirestore(Map<String, dynamic> map) {
    return TaskCmpltdModel(
      userId: map['userId'],
      title: map['title'],
      categ: map['categ'],
      notes: map['notes'],
      isDone: map['isDone'],
    );
  }

}
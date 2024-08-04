class UserModel {

  UserModel({
    required this.name,
    required this.email,
    required this.completedTask,
    required this.pendingTask,
  });

  String? name, email;
  int? completedTask, pendingTask;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'completedTask': completedTask,
      'pendingTask': pendingTask,
    };
  }

  //to fetch data from cloud firestore
  factory UserModel.fromFirestore(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      completedTask: map['completedTask'],
      pendingTask: map['pendingTask'],
    );
  }

}

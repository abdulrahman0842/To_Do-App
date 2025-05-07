class ToDoModel {
  int id;
  String title;
  bool completed;
  ToDoModel({required this.id, required this.title, required this.completed});

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
        id: json["id"], title: json["title"], completed: json["completed"]);
  }
}

class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;

  TaskModel(
      {required this.date,
      required this.description,
      this.id = '',
      this.isDone = false,
      required this.title});

  TaskModel.fromjson(Map<String, dynamic> json)
      : this(
            date: json['date'],
            description: json['description'],
            id: json['id'],
            isDone: json['isDone'],
            title: json['title']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'description': description,
      'isDone': isDone,
      'title': title
    };
  }
}

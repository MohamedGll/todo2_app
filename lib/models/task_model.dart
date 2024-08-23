class TaskModel {
  String id;
  String title;
  String desc;
  bool isDone;
  int date;
  String userId;

  TaskModel({
    this.id = "",
    required this.title,
    required this.desc,
    this.isDone = false,
    required this.date,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title'],
          desc: json['desc'],
          date: json['date'],
          id: json['id'],
          isDone: json['isDone'],
          userId: json['userId'],
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'date': date,
      'id': id,
      'isDone': isDone,
      'userId': userId,
    };
  }
}

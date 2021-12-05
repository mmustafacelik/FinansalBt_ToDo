import 'package:to_do_project/models/db.dart';

class Todo extends DatabaseModel{
  final int? id;
  final int? taskId;
  String? title;
  int isDone;
  String? description;

  Todo({
    this.id,
    this.taskId,
    this.title,
    this.isDone = 0,
    this.description
  });

  // Convert a Task into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskid': taskId,
      'title': title,
      'isDone': isDone,
      'description': description
    };
  }
}
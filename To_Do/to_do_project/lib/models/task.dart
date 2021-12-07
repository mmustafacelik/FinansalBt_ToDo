import 'package:to_do_project/models/db.dart';

class Task extends DatabaseModel{
  final int? id;
  String? title;
  String? description;
  int isActive;

  Task({
    this.id,
    this.title,
    this.description,
    this.isActive = 0,
  });

  // Convert a Task into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isActive': isActive,
    };
  }
}
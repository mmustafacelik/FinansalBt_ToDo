import 'package:to_do_project/database.dart';
import 'package:to_do_project/models/task.dart';

Future<List<Task>> getTasks() async {
  // Get a reference to the database.
  final db = await DatabaseHelper().connection;

  // Query the table for all the tasks.
  final List<Map<String, dynamic>> maps = await db.query('tasks');

  return List.generate(maps.length, (i) {
    return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description']
    );
  });
}

void CreateTask() async{
  await DatabaseHelper().insertRecord('tasks', Task(title: "Yeni İş", description: "Örnek iş açıklaması"));
}

void DeleteTask(int id) async{
  await DatabaseHelper().deleteRecord('tasks', id);
}

void UpdateTask(Task task) async {
  await DatabaseHelper().updateRecord('tasks', task);
}



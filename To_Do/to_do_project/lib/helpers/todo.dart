import 'package:to_do_project/database.dart';
import 'package:to_do_project/models/todo.dart';

void CreateTodo(int taskId) async {
  await DatabaseHelper().insertRecord('todos', Todo(title: "Yeni iş", description: "Örnek açıklama", taskId: taskId));
}

void DeleteTodo(int id) async {
  await DatabaseHelper().deleteRecord('todos', id);
}

void UpdateTodo(Todo todo) async {
  await DatabaseHelper().updateRecord('todos', todo);
}

Future<List<Todo>> GetTodos(int taskid) async {
  // Get a reference to the database.
  final db = await DatabaseHelper().connection;

  // Query the table for all the tasks.
  final List<Map<String, dynamic>> maps = await db.query('todos', where: 'taskid = ?', whereArgs: [taskid]);

  return List.generate(maps.length, (i) {
    return Todo(
        id: maps[i]['id'],
        taskId: maps[i]['taskid'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isDone: maps[i]['isDone']
    );
  });
}


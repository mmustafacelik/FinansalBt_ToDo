import 'package:to_do_project/database.dart';
import 'package:to_do_project/models/task.dart';
import 'dart:async';

void CreateTask() async{
  var database = DatabaseHelper();
  await database.insertTask(Task(title: "New task"));

  var ll = await database.tasks();
  for(final e in ll){
    print(e.id);
    print(e.title);
  }
}
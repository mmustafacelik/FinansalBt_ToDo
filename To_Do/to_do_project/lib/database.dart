import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_project/models/task.dart';
import 'dart:async';


class DatabaseHelper {
  late final Future<Database> connection;

  /*DatabaseHelper() {
    connection = db();
  }*/

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal() {
    connection = db();
  }



  Future<Database> db() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'task_database_test.db'),
      // When the database is first created, create a table to store tasks.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  // Define a function that inserts tasks into the database
  Future<void> insertTask(Task task) async {
    // Get a reference to the database.
    final db = await connection;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    // Get a reference to the database.
    final db = await connection;

    // Update the given Dog.
    await db.update(
      'tasks',
      task.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    // Get a reference to the database.
    final db = await connection;

    // Remove the Dog from the database.
    await db.delete(
      'tasks',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // A method that retrieves all the tasks from the tasks table.
  Future<List<Task>> tasks() async {
    // Get a reference to the database.
    final db = await connection;

    // Query the table for all the tasks.
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
      );
    });
  }
}
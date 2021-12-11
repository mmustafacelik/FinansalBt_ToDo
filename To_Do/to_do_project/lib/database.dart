import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_project/models/db.dart';
import 'dart:async';


class DatabaseHelper {
  late final Future<Database> connection;

  static const tableTask = 'CREATE TABLE IF NOT EXISTS tasks(id INTEGER PRIMARY KEY NOT NULL, title TEXT, description TEXT, isActive BOOLEAN NOT NULL CHECK (isActive IN (0,1)))';
  static const tableTodo = 'CREATE TABLE IF NOT EXISTS todos('
      'id INTEGER PRIMARY KEY NOT NULL,'
      'title TEXT,'
      'description TEXT,'
      'taskid INTEGER,'
      'isDone BOOLEAN NOT NULL CHECK (isDone IN (0,1)),'
      'FOREIGN KEY(taskid) REFERENCES tasks(id) ON DELETE CASCADE'
      ')';


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

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> db() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'tasks_databasev26.db'),
      // When the database is first created, create a table to store tasks.
      onConfigure: _onConfigure,
      onCreate: (db, version) async{
        // Run the CREATE TABLE statement on the database.
        try {
          await db.execute(tableTask);
          await db.execute(tableTodo);
        } catch(err) {
          print(err);
        }
        return;
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
    );
  }

  // Define a function that inserts tasks into the database
  Future<void> insertRecord(String table, DatabaseModel model) async {
    // Get a reference to the database.
    final db = await connection;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      table,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRecord(String table, DatabaseModel model) async {
    // Get a reference to the database.
    final db = await connection;

    // Update the given Dog.
    await db.update(
      table,
      model.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [model.id],
    );
  }

  Future<void> deleteRecord(String table, int id) async {
    // Get a reference to the database.
    final db = await connection;

    // Remove the Dog from the database.
    await db.delete(
      table,
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

}
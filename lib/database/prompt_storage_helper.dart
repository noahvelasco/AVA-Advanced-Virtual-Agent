import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*
Prompt database:

title: title for prompt
prompt: the full prompt text that will user will use
status: default or custom to identify which can be edited/deleted. Default stays.
*/

class PromptStorageHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'prompt_database.db');

    return await openDatabase(dbPath,
        version: 1,
        onCreate: _createDatabase,
        onConfigure: _initializeDefaultPrompts);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE prompt_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        prompt TEXT,
        status TEXT
      )
    ''');
  }

  void deleteDB() async {
    Database db = await database;
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'prompt_database.db');
    //close the connections
    await db.close();
    // Delete the database
    await deleteDatabase(dbPath);
    debugPrint("Deleted the database!");
  }

  Future<int> insertData(String title, String prompt, String status) async {
    Database db = await database;
    Map<String, dynamic> data = {
      'title': title,
      'prompt': prompt,
      'status': status,
    };
    return await db.insert('prompt_table', data);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    debugPrint("GETTING DATA");
    Database db = await database;
    return await db.query('prompt_table');
  }

  //For debugging purposes
  void printTableData() async {
    Database db = await database;
    debugPrint('Printing DB');

    final tableData = await db.rawQuery('SELECT * FROM prompt_table');
    for (final row in tableData) {
      final id = row['id'];
      final title = row['title'];
      final prompt = row['prompt'];
      final status = row['status'];

      debugPrint('ID: $id');
      debugPrint('Title: $title');
      debugPrint('Prompt: $prompt');
      debugPrint('Status: $status');
      debugPrint('-----------------------');
    }

    db.close();
  }

  Future<int> updateData(
      int id, String title, String prompt, String status) async {
    Database db = await database;
    Map<String, dynamic> data = {
      'title': title,
      'prompt': prompt,
      'status': status,
    };
    return await db
        .update('prompt_table', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(int id) async {
    debugPrint("Deleted element id @ $id!");
    Database db = await database;
    return await db.delete('prompt_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllData() async {
    debugPrint("Deleted the prompt table!");
    Database db = await database;
    return await db.delete('prompt_table');
  }

  Future<void> _initializeDefaultPrompts(Database db) async {
    await insertData(
        "Follow-Up 1", "Explain that again to me but like I'm 10", "default");

    await insertData("Follow-Up 2", "Can you elaborate?", "default");

    await insertData("Productivity 1",
        "Generate various solutions to [problem]\nproblem: ", "default");

    await insertData("Productivity 2",
        "How can I make [task] more enjoyable or engaging?\ntask: ", "default");

    await insertData(
        "Marketing 1",
        "Evaluate the viability of launching a business in [business idea] while targeting [target audience]\nbusiness idea:\ntarget audience:",
        "default");

    await insertData(
        "Entreprenuership 1",
        "In short, what are the key elements I should have within my pitch deck?",
        "default");
  }
}

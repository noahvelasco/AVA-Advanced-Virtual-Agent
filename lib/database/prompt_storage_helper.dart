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
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'prompt_database.db');

    Database db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDatabase,
    );

    //after creating db then initialize the prompts
    _initializeDefaultPrompts(db);

    return db;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE prompt_table (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, prompt TEXT, status TEXT)');
  }

  Future<int> insertData(String title, String prompt, String status) async {
    Database db = await database;
    Map<String, String> data = {
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

  Future<void> deleteTable() async {
    Database db = await database;
    await db.execute('DROP TABLE IF EXISTS prompt_table');
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

  Future<void> _initializeDefaultPrompts(Database db) async {
    final existingPrompts = await db.query('prompt_table');
    debugPrint(
        '\n\n ===============\n Initializing Default Prompts... \n===============\n\n');
    if (existingPrompts.isEmpty) {
      await insertData("Follow-Up 1", "WWJD?", "default");
      await insertData("Follow-Up 2", "Are you sure?", "default");
      await insertData("Follow-Up 3", "Why?", "default");
      await insertData("Follow-Up 4", "Tell me more.", "default");
      await insertData(
          "Follow-Up 5", "Explain that again to me but like I'm 10", "default");
    }
    debugPrint(
        '\n\n ===============\n Initialized Default Prompts... \n===============\n\n');
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
  }
}

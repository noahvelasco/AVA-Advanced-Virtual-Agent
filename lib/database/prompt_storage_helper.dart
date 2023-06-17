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
    await _initializeDefaultPrompts(db);

    return db;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE prompt_table (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, prompt TEXT, status TEXT)');
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await database;
    return db.query('prompt_table');
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
        '\n\n==============================\n Initializing Default Prompts...\n==============================\n\n');
    if (existingPrompts.isEmpty) {
      await db.insert('prompt_table', {
        'title': 'Follow-Up 1',
        'prompt': 'Are you sure?',
        'status': 'default'
      });

      await db.insert('prompt_table',
          {'title': 'Follow-Up 2', 'prompt': 'Why?', 'status': 'default'});

      await db.insert('prompt_table', {
        'title': 'Follow-Up 1',
        'prompt': 'Tell me more?',
        'status': 'default'
      });

      await db.insert('prompt_table',
          {'title': 'Follow-Up 4', 'prompt': 'WWJD?', 'status': 'default'});

      await db.insert('prompt_table', {
        'title': 'Follow-Up 5',
        'prompt': 'Explain that again to me but like I\'m 10?',
        'status': 'default'
      });

      await db.insert('prompt_table', {
        'title': 'Follow-Up 6',
        'prompt': 'Has this be proven scientifically?',
        'status': 'default'
      });

      await db.insert('prompt_table', {
        'title': 'Follow-Up 7',
        'prompt': 'What are the sources for this claim?',
        'status': 'default'
      });
    }
    debugPrint(
        '\n\n==============================\n Initialized Default Prompts...\n==============================\n\n');
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

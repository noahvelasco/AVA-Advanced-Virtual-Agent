import 'dart:async';
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
    String dbPath = join(databasesPath, 'my_database.db');

    return await openDatabase(dbPath, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        prompt TEXT,
        status TEXT
      )
    ''');
  }

  Future<int> insertData(String title, String prompt, String status) async {
    Database db = await database;
    Map<String, dynamic> data = {
      'title': title,
      'prompt': prompt,
      'status': status,
    };
    return await db.insert('my_table', data);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await database;
    return await db.query('my_table');
  }

  Future<int> updateData(
      int id, String title, String prompt, String status) async {
    Database db = await database;
    Map<String, dynamic> data = {
      'title': title,
      'prompt': prompt,
      'status': status,
    };
    return await db.update('my_table', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(int id) async {
    Database db = await database;
    return await db.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllData() async {
    Database db = await database;
    return await db.delete('my_table');
  }

  void initializeDefaultPrompts() async {
    await insertData(
        "Follow-Up 1",
        "What are the key concepts I should focus on in this subject?",
        "default");

    await insertData(
        "Follow-Up 2", "Explain that again to me but like I'm 10", "default");

    await insertData("Follow-Up 3", "Can you elaborate?", "default");

    await insertData("Productivity 1",
        "Generate various solutions to [problem]\nproblem: ", "default");

    await insertData("Productivity 2",
        "How can I make [task] more enjoyable or engaging?\ntask: ", "default");

    await insertData(
        "Health 1",
        "How long should I fast until I activate Atophagy in my body?",
        "default");

    await insertData(
        "Health 2", "How can I clean the chemicals off my fruit?", "default");

    await insertData(
        "Marketing 1",
        "Evaluate the viability of launching a business in [business idea] while targeting [target audience]\nbusiness idea:\ntarget audience:",
        "default");

    await insertData(
        "Marketing 2",
        "How could I boost reach and revenue through a business in [business idea]\nBusiness idea: ",
        "default");

    await insertData(
        "Entreprenuership 1",
        "In short, what are the key elements I should have within my pitch deck?",
        "default");

    await insertData(
        "Entreprenuership 2",
        "What do investors value in a [business type] business?\nbusiness type: ",
        "default");
  }
}

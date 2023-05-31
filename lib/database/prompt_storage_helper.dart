import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
        prompt TEXT
      )
    ''');
  }

  Future<int> insertData(String title, String prompt) async {
    Database db = await database;
    Map<String, dynamic> data = {
      'title': title,
      'prompt': prompt,
    };
    return await db.insert('my_table', data);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await database;
    return await db.query('my_table');
  }

  Future<int> updateData(int id, String title, String prompt) async {
    Database db = await database;
    Map<String, dynamic> data = {
      'title': title,
      'prompt': prompt,
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
}

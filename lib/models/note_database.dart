import 'package:flutter_learn/models/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  final String _databaseName = "NotesDatabase.db";
  final String _tableName = "Notes";
  final int _versionDatabase = 1;

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return await _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _versionDatabase,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        noteColor TEXT
      );''',
    );
  }

  Future<List<Note>> all() async {
    var db = await database();
    return List<Note>.from(await db.query(_tableName));
  }

  Future<int> insertNote(Note note) async {
    var db = await database();
    return await db.insert(
      _tableName,
      note.toMap(),
    );
  }

  Future<int> updateNote(Note note) async {
    var db = await database();
    return await db.update(
      _tableName,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }
}

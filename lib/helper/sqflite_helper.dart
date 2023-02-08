import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqfliteHelperClass {
  final String _dbName = "AlarmYagrariksa.DB";
  final int _version = 1;

  Database? _db;
  Future<Database> db() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      _dbName,
      version: _version,
      onCreate: _onCreate,
    );
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE alarms (
      _id INTEGER PRIMARY KEY AUTOINCREMENT,
      uid TEXT,
      name TEXT NULL,
      day TEXT,
      time TEXT,
      active bool    )''');
  }

  Future<void> closeDB() async {
    await _db?.close();
  }
}

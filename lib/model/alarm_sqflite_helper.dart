import 'package:flutter_learn/helper/sqflite_helper.dart';
import 'package:flutter_learn/model/alarm.dart';
import 'package:sqflite/sqflite.dart';

class AlarmSqfliteHelper {
  static Future<List<Map<String, dynamic>>> loadAll() async {
    SqfliteHelperClass dbHelper = SqfliteHelperClass();

    Database db = await dbHelper.db();

    List<Map<String, dynamic>> queryResult = await db.query(Alarm.tableName);

    // await dbHelper.closeDB();

    return queryResult;
  }

  static Future<void> insert(Alarm alarm) async {
    SqfliteHelperClass dbHelper = SqfliteHelperClass();

    Database db = await dbHelper.db();

    db.insert(Alarm.tableName, alarm.toMap());

    // await dbHelper.closeDB();
  }

  static Future<void> update(Alarm alarm) async {
    SqfliteHelperClass dbHelper = SqfliteHelperClass();

    Database db = await dbHelper.db();

    db.update(
      Alarm.tableName,
      alarm.toMap(),
      where: 'uid = ?',
      whereArgs: [alarm.toMap()['uid']],
    );

    // await dbHelper.closeDB();
  }

  static Future<void> delete(String uid) async {
    SqfliteHelperClass dbHelper = SqfliteHelperClass();

    Database db = await dbHelper.db();

    db.delete(
      Alarm.tableName,
      where: 'uid = ?',
      whereArgs: [uid],
    );

    // await dbHelper.closeDB();
  }
}

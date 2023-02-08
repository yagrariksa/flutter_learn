import 'package:flutter_learn/helper/sqflite_helper.dart';
import 'package:flutter_learn/model/alarm.dart';
import 'package:sqflite/sqflite.dart';

class AlarmSqfliteHelper {
  final SqfliteHelperClass dbHelper = SqfliteHelperClass();

  Future<List<Map<String, dynamic>>> loadAll() async {
    Database db = await dbHelper.db();

    List<Map<String, dynamic>> queryResult = await db.query(Alarm.tableName);
    print("Success get ${queryResult.length} data");

    return queryResult;
  }

  Future<void> insert(Alarm alarm) async {
    Database db = await dbHelper.db();

    db.insert(Alarm.tableName, alarm.toMap());

    // await dbHelper.closeDB();
  }

  Future<void> update(Alarm alarm) async {
    Database db = await dbHelper.db();

    db.update(
      Alarm.tableName,
      alarm.toMap(),
      where: 'uid = ?',
      whereArgs: [alarm.toMap()['uid']],
    );

    // await dbHelper.closeDB();
  }

  Future<void> delete(String uid) async {
    Database db = await dbHelper.db();

    db.delete(
      Alarm.tableName,
      where: 'uid = ?',
      whereArgs: [uid],
    );

    // await dbHelper.closeDB();
  }
}

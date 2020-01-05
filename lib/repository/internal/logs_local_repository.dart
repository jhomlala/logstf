import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/utils/app_const.dart';
import 'package:sqflite/sqflite.dart';

import 'app_database_provider.dart';

class LogsLocalRepository {
  final AppDatabase appDatabase;
  Database _database;

  LogsLocalRepository(this.appDatabase);

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await appDatabase.database;
    await _database.execute("CREATE TABLE IF NOT EXISTS LogShort ("
        "id INTEGER PRIMARY KEY,"
        "title TEXT,"
        "map TEXT,"
        "date INTEGER,"
        "views INTEGER,"
        "players INTEGER"
        ")");
    return _database;
  }

  Future<int> createLog(LogShort logShort) async {
    final db = await database;
    var res = await db.insert(AppConst.logShortTableName, logShort.toJson());
    return res;
  }

  Future<LogShort> getLog(int logId) async {
    final db = await database;
    var res = await db
        .query(AppConst.logShortTableName, where: "id = ?", whereArgs: [logId]);
    return res.isNotEmpty ? LogShort.fromJson(res.first) : null;
  }

  Future<List<LogShort>> getLogs() async {
    final db = await database;
    var res = await db.query(AppConst.logShortTableName);
    List<LogShort> list =
        res.isNotEmpty ? res.map((c) => LogShort.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteLog(int logId) async {
    final db = await database;
    var res = await db.delete(AppConst.logShortTableName,
        where: "id = ?", whereArgs: [logId]);
    return res;
  }

  Future<int> deleteLogs() async {
    final db = await database;
    var res = await db.delete(AppConst.logShortTableName);
    return res;
  }

  Future<int> getLogsCount() async {
    final db = await database;
    var countRaw =
        await db.rawQuery("SELECT COUNT(*) FROM ${AppConst.logShortTableName}");
    return Sqflite.firstIntValue(countRaw);
  }
}

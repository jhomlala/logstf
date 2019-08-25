import 'dart:io';

import 'package:logstf/model/log_short.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'app_database_provider.dart';

class LogsLocalRepository {
  LogsLocalRepository._();

  static final LogsLocalRepository db = LogsLocalRepository._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await AppDatabase.database;
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
    var res = await db.insert("LogShort", logShort.toJson());
    return res;
  }

  Future<LogShort> getLog(int logId) async {
    final db = await database;
    var res = await db.query("LogShort", where: "id = ?", whereArgs: [logId]);
    return res.isNotEmpty ? LogShort.fromJson(res.first) : null;
  }

  Future<List<LogShort>> getLogs() async {
    final db = await database;
    var res = await db.query("LogShort");
    List<LogShort> list =
        res.isNotEmpty ? res.map((c) => LogShort.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteLog(int logId) async {
    final db = await database;
    var res = await db.delete("LogShort", where: "id = ?", whereArgs: [logId]);
    return res;
  }

  Future<int> deleteLogs() async {
    final db = await database;
    var res = await db.delete("LogShort");
    return res;
  }
}

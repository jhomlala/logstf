import 'dart:io';

import 'package:logstf/model/log_short.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LogsLocalRepository {
  LogsLocalRepository._();

  static final LogsLocalRepository db = LogsLocalRepository._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "logstf.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE LogShort ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "map TEXT,"
          "date INTEGER,"
          "views INTEGER,"
          "players INTEGER"
          ")");
    });
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
}

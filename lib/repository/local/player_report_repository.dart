import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'app_database_provider.dart';

class PlayerReportRepository{
  PlayerReportRepository._();

  static final PlayerReportRepository db = PlayerReportRepository._();
  static Database _database;

  Future<Database> createDatabase(String steamId64) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$steamId64.db");
    print("Creating database: $path");
    return await openDatabase(path, version: 1);
  }


  Future<Database> get database async {
    if (_database != null) return _database;
    
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
}
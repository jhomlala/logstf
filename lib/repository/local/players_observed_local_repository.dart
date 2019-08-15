import 'dart:io';

import 'package:logstf/model/player_observed.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlayersObservedLocalRepository {
  PlayersObservedLocalRepository._();

  static final PlayersObservedLocalRepository db =
      PlayersObservedLocalRepository._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "logstf.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE PlayerObserved ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "steamid64 TEXT"
          ")");
    });
  }

  Future<int> createPlayerObserved(PlayerObserved playerObserved) async {
    final db = await database;
    var res = await db.insert("PlayerObserved", playerObserved.toJson());
    return res;
  }

  Future<PlayerObserved> getPlayerObserved(int id) async {
    final db = await database;
    var res =
        await db.query("PlayerObserved", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? PlayerObserved.fromJson(res.first) : null;
  }

  Future<PlayerObserved> getPlayerObservedWithSteamId64(String steamId64) async {
    final db = await database;
    var res =
    await db.query("PlayerObserved", where: "steamid64 = ?", whereArgs: [steamId64]);
    return res.isNotEmpty ? PlayerObserved.fromJson(res.first) : null;
  }

  Future<List<PlayerObserved>> getPlayersObserved() async {
    final db = await database;
    var res = await db.query("PlayerObserved");
    List<PlayerObserved> list = res.isNotEmpty
        ? res.map((c) => PlayerObserved.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<int> deletePlayerObserved(int id) async {
    final db = await database;
    var res =
        await db.delete("PlayerObserved", where: "id = ?", whereArgs: [id]);
    return res;
  }
}

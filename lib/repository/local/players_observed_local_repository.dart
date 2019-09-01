import 'package:logstf/model/player_observed.dart';
import 'package:logstf/util/app_const.dart';
import 'package:sqflite/sqflite.dart';

import 'app_database_provider.dart';

class PlayersObservedLocalRepository {
  PlayersObservedLocalRepository._();

  static final PlayersObservedLocalRepository db =
  PlayersObservedLocalRepository._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await AppDatabase.database;
    if (_database != null) {
      await _database.execute("CREATE TABLE IF NOT EXISTS PlayerObserved ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "steamid64 TEXT"
          ")");
    }

    return _database;
  }

  Future<int> createPlayerObserved(PlayerObserved playerObserved) async {
    final db = await database;
    var res = await db.insert(
        AppConst.playerObservedTableName, playerObserved.toJson());
    return res;
  }

  Future<PlayerObserved> getPlayerObserved(int id) async {
    final db = await database;
    var res =
    await db.query(
        AppConst.playerObservedTableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? PlayerObserved.fromJson(res.first) : null;
  }

  Future<PlayerObserved> getPlayerObservedWithSteamId64(
      String steamId64) async {
    final db = await database;
    var res = await db.query(AppConst.playerObservedTableName,
        where: "steamid64 = ?", whereArgs: [steamId64]);
    return res.isNotEmpty ? PlayerObserved.fromJson(res.first) : null;
  }

  Future<List<PlayerObserved>> getPlayersObserved() async {
    final db = await database;
    var res = await db.query(AppConst.playerObservedTableName);
    List<PlayerObserved> list = res.isNotEmpty
        ? res.map((c) => PlayerObserved.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<int> deletePlayerObserved(int id) async {
    final db = await database;
    var res =
    await db.delete(
        AppConst.playerObservedTableName, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deletePlayersObserved() async {
    final db = await database;
    var res = await db.delete(AppConst.playerObservedTableName);
        return res;
    }
}

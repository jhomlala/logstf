import 'package:logstf/model/watched_player.dart';

class AppSettings {
  List<WatchedPlayer> watchedPlayers;

  AppSettings({this.watchedPlayers});

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
      watchedPlayers: new List<WatchedPlayer>.from(
          json["watchedPlayers"].map((x) => WatchedPlayer.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "watchedPlayers":
            new List<dynamic>.from(watchedPlayers.map((x) => x.toJson()))
      };
}

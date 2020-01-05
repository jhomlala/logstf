import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:logstf/model/external/player_search_result.dart';
import 'package:logstf/utils/app_utils.dart';

class PlayerRemoteRepository {
  final Dio dio;

  PlayerRemoteRepository(this.dio);

  Future<List<PlayerSearchResult>> searchPlayers(String playerName) async {
    List<PlayerSearchResult> results = List();
    String url = "http://logs.tf/search/player?s=$playerName";
    Response<String> response = await dio.get(url);
    if (response != null) {
      String html = response.toString();
      var document = parse(html);
      var playersTable = document.getElementsByClassName("table-players");
      if (playersTable != null && playersTable.isNotEmpty) {
        var playersTableChildrenRoot = playersTable.first.children.first;

        playersTableChildrenRoot.children.forEach((trElement) {
          String playerId = "";
          List<String> playerNames = List();
          String steamId = "";
          String avatarUrl;

          for (int index = 0; index < trElement.children.length; index++) {
            var tdElement = trElement.children[index];
            if (index == 0) {
              playerId = tdElement.text;
            }
            if (index == 1) {
              var innerTdElements = tdElement.children;
              Element playerNameElement;
              if (innerTdElements.length == 1) {
                playerNameElement = innerTdElements[0];
              } else {
                avatarUrl = innerTdElements.first.attributes["src"];
                playerNameElement = innerTdElements[1];
              }

              playerNames = playerNameElement.text
                  .replaceAll(RegExp(r"\s+\b|\b\s"), "")
                  .split(",");

              playerNames = List()
                ..addAll(playerNames.map((String playerName) {
                  return playerName.trim();
                }));
            }
            if (index == 2) {
              steamId = AppUtils.convertSteamId3ToSteamId64(tdElement.text)
                  .toString();
            }
          }
          results.add(
              PlayerSearchResult(playerId, playerNames, avatarUrl, steamId));
        });
      }
    }
    return results;
  }
}

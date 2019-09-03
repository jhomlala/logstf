import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:logstf/model/player_search_result.dart';
import 'package:logstf/util/app_utils.dart';

class LogsPlayerSearchRepository {
  Dio dio = Dio();

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
              avatarUrl = innerTdElements.first.attributes["src"];
              playerNames = innerTdElements[1]
                  .text
                  .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
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

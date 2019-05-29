import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

class LogPlayerAwardsView extends StatelessWidget {
  final Log log;
  final Player player;

  const LogPlayerAwardsView(this.log, this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getAwardCard(
                  "Most valuable players",
                  "Players which were most valuable in game",
                  LogHelper.getPlayerSortedByMVPScore(log)),
              _getAwardCard("Top kills", "Players which had most kills overall",
                  LogHelper.getPlayersSortedByKills(log)),
              _getAwardCard(
                  "Top assists",
                  "Players which had most asissts overall",
                  LogHelper.getPlayersSortedByAssists(log, true)),
              _getAwardCard(
                  "Top damage",
                  "Players which dealed the most damage",
                  LogHelper.getPlayersSortedByDamage(log)),
              _getAwardCard(
                  "Top medic kills",
                  "Players which killed most medics",
                  LogHelper.getPlayersSortedByMedicKills(log)),
              _getAwardCard(
                  "Top kills per deaths",
                  "Players which had best kills per death",
                  LogHelper.getPlayersSortedByKPD(log)),
              _getAwardCard(
                  "Top kills & assists per death",
                  "Players which had best kills & assists per deaths",
                  LogHelper.getPlayersSortedByKPD(log)),
            ],
          ),
        ));
  }

  Card _getAwardCard(
      String name, String description, List<Player> sortedPlayers) {
    int playerIndex = 0;
    for (int index = 0; index < sortedPlayers.length; index++) {
      if (sortedPlayers[index].steamId == player.steamId) {
        playerIndex = index;
        break;
      }
    }
    var position = playerIndex + 1;

    String placeImage;
    if (position == 1) {
      placeImage = "assets/first_place.png";
    }
    if (position == 2) {
      placeImage = "assets/second_place.png";
    } else if (position == 3) {
      placeImage = "assets/third_place.png";
    }

    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(name, style: TextStyle(fontSize: 20)),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text(description),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Position: $position",
              style: TextStyle(fontSize: 16),
            ),
            placeImage != null
                ? Image.asset(
                    placeImage,
                    height: 20,
                    width: 20,
                  )
                : Container()
          ]),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
        ],
      ),
    );
  }
}

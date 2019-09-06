import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

class LogPlayerAwardsView extends StatelessWidget {
  final Log _log;
  final Player _player;

  const LogPlayerAwardsView(this._log, this._player);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: getAwards(),
          ),
        ));
  }

  List<Widget> getAwards() {
    List<Widget> awards = List();
    awards.add(_getAwardCard(
        "Most valuable players",
        "Players which were most valuable in game. See help for more info.",
        LogHelper.getPlayerSortedByMVPScore(_log)));

    awards.add(_getAwardCard(
        "Top kills",
        "Players which had most kills overall.",
        LogHelper.getPlayersSortedByKills(_log)));

    awards.add(_getAwardCard(
        "Top assists",
        "Players which had most asissts overall.",
        LogHelper.getPlayersSortedByAssists(_log, true)));

    awards.add(_getAwardCard(
        "Top damage",
        "Players which dealed the most damage.",
        LogHelper.getPlayersSortedByDamage(_log)));

    awards.add(_getAwardCard(
        "Top medic kills",
        "Players which killed most medics.",
        LogHelper.getPlayersSortedByMedicKills(_log)));

    awards.add(_getAwardCard(
        "Top kills per deaths",
        "Players which had best kills per death.",
        LogHelper.getPlayersSortedByKPD(_log)));

    awards.add(_getAwardCard(
        "Top kills & assists per death",
        "Players which had best kills & assists per deaths.",
        LogHelper.getPlayersSortedByKPD(_log)));

    if (_player.dapm >= 500) {
      awards.add(_getSpecialAwardCard(
          "500 DPM Club", "Players who had 500+ DPM in a game."));
    }

    if (_player.dmg >= 10000) {
      awards.add(_getSpecialAwardCard(
          "10000 DMG Club", "Players who had 10k DMG in a game."));
    }

    if (_player.deaths == 0) {
      awards.add(_getSpecialAwardCard(
          "Deathless", "Players who had 0 deaths in a game."));
    }

    return awards;
  }

  Card _getSpecialAwardCard(String name, String description) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(children: <Widget>[
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
      ]),
    );
  }

  Card _getAwardCard(
      String name, String description, List<Player> sortedPlayers) {
    int playerIndex = 0;
    for (int index = 0; index < sortedPlayers.length; index++) {
      if (sortedPlayers[index].steamId == _player.steamId) {
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
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
              )),
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

import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/award_card.dart';
import 'package:logstf/widget/class_icon.dart';

class LogAwardsView extends StatefulWidget {
  final Log log;

  const LogAwardsView({Key key, this.log}) : super(key: key);

  @override
  _LogAwardsViewState createState() => _LogAwardsViewState();
}

class _LogAwardsViewState extends State<LogAwardsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.deepPurple,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            AwardCard(
              awardName: "Most valuable players",
              players: getTopMVPPlayers(),
              log: widget.log,
              description: "Players which were most valuable in game",
            ),
            AwardCard(
              awardName: "Top kills",
              players: getTopKillPlayers(),
              log: widget.log,
              description: "Players which had most kills overall",
            ),
            AwardCard(
              awardName: "Top assists",
              players: getTopAssistsPlayers(),
              log: widget.log,
              description:
                  "Players which had most asissts overall (without medics)",
            ),
            AwardCard(
              awardName: "Top damage",
              players: getTopDamagePlayers(),
              log: widget.log,
              description: "Players which dealed the most damage",
            ),
            AwardCard(
              awardName: "Top medic kills",
              players: getTopDamagePlayers(),
              log: widget.log,
              description: "Players which killed most medics",
            )
          ],
        )));
  }

  List<Player> getTopKillPlayers() {
    return LogHelper.getPlayersSortedByKills(_getLog()).sublist(0, 3);
  }

  List<Player> getTopAssistsPlayers() {
    return LogHelper.getPlayersSortedByAssistsWithoutMedic(_getLog())
        .sublist(0, 3);
  }

  List<Player> getTopDamagePlayers() {
    return LogHelper.getPlayersSortedByDamage(_getLog()).sublist(0, 3);
  }

  List<Player> getTopMedicKillsPlayers() {
    return LogHelper.getPlayersSortedByMedicKills(_getLog()).sublist(0, 3);
  }

  List<Player> getTopMVPPlayers() {
    LogHelper.getPlayerSortedByMVPScore(_getLog()).forEach((player) => print(
        _getLog().getPlayerName(player.steamId) +
            " score: " +
            LogHelper.getPlayerMVPScore(player, _getLog()).toString()));
    return LogHelper.getPlayerSortedByMVPScore(_getLog()).sublist(0, 3);
  }

  Log _getLog() {
    return widget.log;
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/award_card.dart';

class LogAwardsView extends StatefulWidget {
  @override
  _LogAwardsViewState createState() => _LogAwardsViewState();
}

class _LogAwardsViewState extends State<LogAwardsView> {
  Log _log;

  @override
  void initState() {
    _log = logDetailsBloc.logSubject.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            AwardCard(
              awardName: "Most valuable players",
              players: getTopMVPPlayers(),
              log: _log,
              description: "Players which were most valuable in game",
            ),
            AwardCard(
              awardName: "Top kills",
              players: getTopKillPlayers(),
              log: _log,
              description: "Players which had most kills overall",
            ),
            AwardCard(
              awardName: "Top assists",
              players: getTopAssistsPlayers(),
              log: _log,
              description:
                  "Players which had most asissts overall (without medics)",
            ),
            AwardCard(
              awardName: "Top damage",
              players: getTopDamagePlayers(),
              log: _log,
              description: "Players which dealed the most damage",
            ),
            AwardCard(
              awardName: "Top medic kills",
              players: getTopDamagePlayers(),
              log: _log,
              description: "Players which killed most medics",
            ),
            AwardCard(
              awardName: "Top kills per deaths",
              players: getTopKPDPlayers(),
              log: _log,
              description: "Players which had best kills per deaths",
            ),
            AwardCard(
              awardName: "Top kills & assists per deaths",
              players: getTopKPDPlayers(),
              log: _log,
              description: "Players which had best kills & assists per deaths",
            )
          ],
        )));
  }

  List<Player> getTopList(List<Player> sortedList){
    int count = sortedList.length;
    if (count <= 3){
      return sortedList;
    } else {
      return sortedList.sublist(0,3);
    }
  }

  List<Player> getTopKillPlayers() {
    return getTopList(LogHelper.getPlayersSortedByKills(_log));
  }

  List<Player> getTopAssistsPlayers() {
    return getTopList(LogHelper.getPlayersSortedByAssists(_log, false));
  }

  List<Player> getTopDamagePlayers() {
    return getTopList(LogHelper.getPlayersSortedByDamage(_log));
  }

  List<Player> getTopMedicKillsPlayers() {
    return getTopList(LogHelper.getPlayersSortedByMedicKills(_log));
  }

  List<Player> getTopMVPPlayers() {
    return getTopList(LogHelper.getPlayerSortedByMVPScore(_log));
  }

  List<Player> getTopKPDPlayers() {
    return getTopList(LogHelper.getPlayersSortedByKPD(_log));
  }

  List<Player> getTopKAPDPlayers() {
    return getTopList(LogHelper.getPlayersSortedByKAPD(_log));
  }
}

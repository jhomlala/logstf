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
  int _upperRange;

  @override
  void initState() {
    _log = logDetailsBloc.logSubject.value;
    int playersCount =  _log.players.length;
    if (playersCount <= 4){
      _upperRange = 2;
    } else{
      _upperRange = 3;
    }

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

  List<Player> getTopKillPlayers() {
    return LogHelper.getPlayersSortedByKills(_log).sublist(0, 3);
  }

  List<Player> getTopAssistsPlayers() {
    return LogHelper.getPlayersSortedByAssists(_log, false).sublist(0, 3);
  }

  List<Player> getTopDamagePlayers() {
    return LogHelper.getPlayersSortedByDamage(_log).sublist(0, 3);
  }

  List<Player> getTopMedicKillsPlayers() {
    return LogHelper.getPlayersSortedByMedicKills(_log).sublist(0, 3);
  }

  List<Player> getTopMVPPlayers() {
    return LogHelper.getPlayerSortedByMVPScore(_log).sublist(0, 3);
  }

  List<Player> getTopKPDPlayers() {
    return LogHelper.getPlayersSortedByKPD(_log).sublist(0, 3);
  }

  List<Player> getTopKAPDPlayers() {
    return LogHelper.getPlayersSortedByKAPD(_log).sublist(0, 3);
  }
}

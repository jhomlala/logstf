import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_kill.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/widget/kills_card.dart';

class LogPlayerKillsView extends StatefulWidget {
  final Log log;
  final Player player;

  const LogPlayerKillsView(this.log, this.player);

  @override
  _LogPlayerKillsViewState createState() => _LogPlayerKillsViewState();
}

class _LogPlayerKillsViewState extends State<LogPlayerKillsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
            child: Column(children: _getClassKillsCardsWidgets())));
  }

  List<Widget> _getClassKillsCardsWidgets() {
    ClassKill classKill = LogHelper.getClassKill(widget.log, widget.player);
    if (classKill == null){
      classKill = ClassKill();
    }
    var team = "";
    print("Team: " + widget.player.team);
    if (widget.player.team == "Red") {
      team = "Blue";
    } else {
      team = "Red";
    }

    List<Widget> widgets = List();
    widgets.add(KillsCard(
      className: "scout",
      kills: classKill.scout,
      totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "scout")
    ));

    widgets.add(KillsCard(
      className: "soldier",
      kills: classKill.soldier,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "soldier")
    ));

    widgets.add(KillsCard(
        className: "pyro",
        kills: classKill.pyro,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "pyro")
    ));

    widgets.add(KillsCard(
        className: "demoman",
        kills: classKill.demoman,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "demoman")
    ));

    widgets.add(KillsCard(
        className: "heavyweapons",
        kills: classKill.heavyweapons,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "heavyweapons")
    ));

    widgets.add(KillsCard(
        className: "engineer",
        kills: classKill.engineer,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "engineer")
    ));

    widgets.add(KillsCard(
        className: "medic",
        kills: classKill.medic,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "medic")
    ));

    widgets.add(KillsCard(
        className: "sniper",
        kills: classKill.sniper,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "sniper")
    ));

    widgets.add(KillsCard(
        className: "spy",
        kills: classKill.spy,
        totalClassDeaths: _getDeathsOfClassFromOppositeTeams(team, "spy")
    ));

    return widgets;
  }

  int _getDeathsOfClassFromOppositeTeams(String team, String className) {
    var players = LogHelper.getPlayers(widget.log, team, className: className);
    print("Players: " + players.length.toString() + " team: " + team.toString() + " class: " + className);
    int deaths = LogHelper.sumDeaths(players);
    print("Deaths: " + deaths.toString());
    return deaths;
  }
}

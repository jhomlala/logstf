import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/widget/class_icon.dart';
import 'package:logstf/widget/heal_spread_pie_chart.dart';
import 'package:logstf/widget/medic_stats_widget.dart';

class LogHealView extends StatefulWidget {
  @override
  _LogHealViewState createState() => _LogHealViewState();
}

class _LogHealViewState extends State<LogHealView> {
  Log _log = logDetailsBloc.logSubject.value;
  Map<Player, List<HealSpread>> _healSpreadMap = Map();

  void init(BuildContext context) {
    var medicPlayers = LogHelper.getPlayersWithClass(_log, "medic");
    medicPlayers.forEach((player) {
      var healSpread = LogHelper.getHealSpread(_log, player.steamId);
      if (healSpread != null) {
        _healSpreadMap[player] = healSpread;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    //return HealSpreadPieChart(healSpreadList: _healSpreadMap.values.first);
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: getHealSpreadWidgets(),
          ),
        ));
  }

  List<Widget> getHealSpreadWidgets() {
    List<Widget> widgets = List();
    if (_healSpreadMap != null && _healSpreadMap.isNotEmpty) {
      _healSpreadMap.forEach((player, list) {
        widgets.add(Card(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ClassIcon(
                  playerClass: "medic",
                ),
                Text(
                  _log.getPlayerName(player.steamId),
                  style: TextStyle(
                      fontSize: 24, color: _getPlayerTeamColor(player.steamId)),
                )
              ]),
              Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: 1,
                  color: AppUtils.lightGreyColor),
              MedicStatsWidget(player: player),
              Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: 1,
                  color: AppUtils.lightGreyColor),
              HealSpreadPieChart(healSpreadList: list),
              Padding(
                padding: EdgeInsets.only(top: 10),
              )
            ])));
      });
    } else {
      widgets.add(Card(
          margin: EdgeInsets.all(10),
          child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("There's no medics in this match.")]))));
    }

    return widgets;
  }

  Color _getPlayerTeamColor(String steamId) {
    String team = _log.players[steamId].team;
    if (team == "Red") {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }
}

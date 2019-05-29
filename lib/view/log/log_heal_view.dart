import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:logstf/model/log.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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

  Map<Player, List<HealSpread>> _healSpreadMap;

  void init(BuildContext context) {

    _healSpreadMap = Map();
    var medicPlayers = LogHelper.getPlayersWithClass(_log, "medic");
    medicPlayers.forEach((player) {
      _healSpreadMap[player] = LogHelper.getHealSpread(_log, player.steamId);
    });
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    //return HealSpreadPieChart(healSpreadList: _healSpreadMap.values.first);
    return Container(
        color: Colors.deepPurple,
        child: SingleChildScrollView(
          child: Column(
            children: getHealSpreadWidgets(),
          ),
        ));
  }

  List<Widget> getHealSpreadWidgets() {
    List<Widget> widgets = List();

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
                style: TextStyle(fontSize: 24),
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

    return widgets;
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/external/class_stats.dart';
import 'package:logstf/model/external/heal_spread.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/utils/application_localization.dart';

import '../../common/widget/class_icon.dart';
import 'heal_spread_pie_chart.dart';
import 'medic_stats_widget.dart';
import 'base_overview_card.dart';

class MedicOverviewCard extends BaseOverviewCard {
  MedicOverviewCard(Player player, Log log) : super(player, log);

  @override
  _MedicOverviewCardState createState() => _MedicOverviewCardState();
}

class _MedicOverviewCardState extends BaseOverviewCardState<MedicOverviewCard> {
  List<HealSpread> _healSpread;
  ClassStats _classStats;

  @override
  void initState() {
    _healSpread = LogHelper.getHealSpread(log, player.steamId);
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "medic";
    }).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
              child: Column(
                children: getMedicWidgets(),
              ),
            )));
  }

  List<Widget> getMedicWidgets() {
    var applicationLocalization = ApplicationLocalization.of(context);
    List<Widget> widgets = List();
    widgets.add(Card(
        child: Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ClassIcon(playerClass: "medic"),
        Container(
            child: Text(
          " ${applicationLocalization.getText("log_class_medic_healing_chart")}",
          style: TextStyle(fontSize: 20),
        ))
      ]),
      HealSpreadPieChart(healSpreadList: _healSpread),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
    ])));
    widgets.add(Card(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ClassIcon(playerClass: "medic"),
        Container(
            child: Text(
              " ${applicationLocalization.getText("log_class_highlights")}",
              style: TextStyle(fontSize: 20),
            ))
      ]),
      MedicStatsWidget(player: player, log: log),
      Padding(
        padding: EdgeInsets.only(top: 10),
      )
    ])));

   widgets.add(getWeaponsCard(_classStats));
    return widgets;
  }
}

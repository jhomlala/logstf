import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'base_overview_card.dart';
import 'class_icon.dart';
import 'heal_spread_pie_chart.dart';
import 'medic_stats_widget.dart';

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
                children: getHealSpreadWidgets(),
              ),
            )));
  }

  List<Widget> getHealSpreadWidgets() {
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
          " Healing chart",
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
          " Highlights",
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

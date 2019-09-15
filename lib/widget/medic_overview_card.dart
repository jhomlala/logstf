import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';

import 'base_overview_card.dart';
import 'heal_spread_pie_chart.dart';
import 'medic_stats_widget.dart';

class MedicOverviewCard extends BaseOverviewCard {
  MedicOverviewCard(Player player, Log log) : super(player, log);

  @override
  _MedicOverviewCardState createState() => _MedicOverviewCardState();
}

class _MedicOverviewCardState extends BaseOverviewCardState<MedicOverviewCard> {
  List<HealSpread> _healSpread;

  @override
  void initState() {
    _healSpread = LogHelper.getHealSpread(log, player.steamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child:  Column(
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
          HealSpreadPieChart(healSpreadList: _healSpread),
          Divider(
            color: AppUtils.getBorderColor(context),
          ),
          MedicStatsWidget(player: player, log: log),
          Padding(
            padding: EdgeInsets.only(top: 10),
          )
        ])));
    return widgets;
  }


}

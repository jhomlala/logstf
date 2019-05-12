import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_bloc.dart';
import 'package:logstf/bloc/log_bloc_provider.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:logstf/model/log.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/heal_spread_pie_chart.dart';

class LogHealView extends StatefulWidget {
  @override
  _LogHealViewState createState() => _LogHealViewState();
}

class _LogHealViewState extends State<LogHealView> {
  LogBloc _bloc;
  Log _log;

  Map<Player, List<HealSpread>> _healSpreadMap;

  void init(BuildContext context) {
    _bloc = LogBlocProvider.of(context);
    _log = _bloc.logSubject.value;
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
    return SingleChildScrollView(
      child: Column(

        children: getHealSpreadWidgets(),
      ),
    );
  }

  List<Widget> getHealSpreadWidgets() {
    List<Widget> widgets = List();
    _healSpreadMap.values.forEach(
            (list) => widgets.add(HealSpreadPieChart(healSpreadList: list)));

    return widgets;
  }

}

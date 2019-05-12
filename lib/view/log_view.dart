import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_bloc_provider.dart';
import 'package:logstf/bloc/logs_bloc.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/view/log_general_stats_view.dart';
import 'package:logstf/view/log_heal_view.dart';
import 'package:logstf/view/log_players_kills_view.dart';
import 'package:logstf/view/log_players_stats_view.dart';
import 'package:logstf/view/log_team_stats_view.dart';

class LogView extends StatefulWidget {
  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> with SingleTickerProviderStateMixin {
  LogsBloc logsBloc;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    logsBloc = LogsBloc();
    tabController = TabController(length: 5, vsync: this);
    logsBloc.getLog(2275803);
  }

  @override
  Widget build(BuildContext context) {
    return LogBlocProvider(
        child: Scaffold(
            appBar: AppBar(
                title: Text("Log"),
                bottom: TabBar(controller: tabController, tabs: [
                  Tab(
                    text: "General",
                    icon: Icon(Icons.info_outline),
                  ),
                  Tab(
                    text: "Teams",
                    icon: Icon(Icons.swap_horiz),
                  ),
                  Tab(
                    text: "Players",
                    icon: Icon(Icons.people),
                  ),
                  Tab(
                    text: "Kills",
                    icon: Icon(Icons.album),
                  ),
                  Tab(
                    text: "Heal",
                    icon: Icon(Icons.add),
                  )
                ])),
            body: StreamBuilder<Log>(
                stream: logsBloc.logSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var bloc = LogBlocProvider.of(context);
                    bloc.setLog(snapshot.data);
                    return TabBarView(controller: tabController, children: [
                      LogGeneralStatsView(),
                      LogTeamStatsView(),
                      LogPlayersStatsView(),
                      LogPlayersKillsView(),
                      LogHealView()
                    ]);
                  } else {
                    return Text("No data... Loading..");
                  }
                })));
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_bloc_provider.dart';
import 'package:logstf/bloc/logs_bloc.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/view/log_general_stats_view.dart';
import 'package:logstf/view/log_heal_view.dart';
import 'package:logstf/view/log_players_view.dart';
import 'package:logstf/view/log_team_stats_view.dart';
import 'package:logstf/widget/progress_bar.dart';

import 'log_awards_view.dart';

class LogView extends StatefulWidget {
  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> with SingleTickerProviderStateMixin {
  LogsBloc logsBloc;
  TabController tabController;
  String _appBarTitle = "General stats";

  @override
  void initState() {
    super.initState();
    logsBloc = LogsBloc();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(_onTabChanged);
    logsBloc.getLog(2290040);
  }

  void _onTabChanged() {
    print("Tab changed");
    var index = tabController.index;
    var tabName = "";
    switch (index) {
      case 0:
        tabName = "General stats";
        break;
      case 1:
        tabName = "Team stats";
        break;
      case 2:
        tabName = "Player stats";
        break;
      case 3:
        tabName = "Heal stats";
        break;
      case 4:
        tabName = "Awards stats";
        break;
    }
    setState(() {
      _appBarTitle = tabName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LogBlocProvider(
        child: Scaffold(
            appBar: AppBar(
                title: Text(_appBarTitle),
                elevation: 0.0,
                bottom: TabBar(controller: tabController, indicatorColor: Colors.white, tabs: [
                  Tab(
                    icon: Icon(Icons.info_outline),
                  ),
                  Tab(
                    icon: Icon(Icons.swap_horiz),
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                  ),
                  Tab(
                    icon: Icon(Icons.add),
                  ),
                  Tab(
                    icon: Icon(Icons.flash_on),
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
                      LogTeamStatsView(log: snapshot.data),
                      LogPlayersView(),
                      LogHealView(),
                      LogAwardsView(log: snapshot.data)
                    ]);
                  } else {
                    return Container(
                        decoration: BoxDecoration(color: Colors.deepPurple),
                        child: Center(
                            child:
                                Container(height: 40, child: ProgressBar())));
                  }
                })));
  }
}

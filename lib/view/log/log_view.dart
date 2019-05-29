import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/bloc/logs_bloc.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/view/log/log_general_stats_view.dart';
import 'package:logstf/view/log/log_heal_view.dart';
import 'package:logstf/view/log/log_players_view.dart';
import 'package:logstf/view/log/log_team_stats_view.dart';
import 'package:logstf/widget/progress_bar.dart';

import 'package:logstf/view/log/log_awards_view.dart';
import 'package:provider/provider.dart';

class LogView extends StatefulWidget {
  final int logId;

  const LogView({Key key, this.logId}) : super(key: key);

  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> with SingleTickerProviderStateMixin {
  TabController tabController;
  String _appBarTitle = "General stats";
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    logDetailsBloc.init();
    logDetailsBloc.selectLog(widget.logId);

    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(_onTabChanged);
    _setupLogSavedState();
  }

  @override
  void dispose() {
    logDetailsBloc.dispose();
    super.dispose();
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
    return Scaffold(
        appBar: AppBar(
            title: Text(_appBarTitle),
            elevation: 0.0,
            actions: [
              IconButton(
                icon: Icon(_saved == true ? Icons.star : Icons.star_border),
                onPressed: () {
                  onSaveClicked();
                },
              )
            ],
            bottom: TabBar(
                controller: tabController,
                indicatorColor: Colors.white,
                tabs: [
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
            stream: logDetailsBloc.logSubject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TabBarView(controller: tabController, children: [
                  LogGeneralStatsView(),
                  LogTeamStatsView(),
                  LogPlayersView(),
                  LogHealView(),
                  LogAwardsView()
                ]);
              } else {
                return Container(
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    child: Center(
                        child: Container(height: 40, child: ProgressBar())));
              }
            }));
  }

  void onSaveClicked() async {
    Log log = logDetailsBloc.logSubject.value;
    var savedLog = await logDetailsBloc.getLogFromDatabase(log.id);
    if (savedLog == null) {
      logDetailsBloc.createLogInDatabase(log.setupShortLog());
      setState(() {
        _saved = true;
      });
    } else {
      logDetailsBloc.deleteLogFromDatabase(log.id);
      setState(() {
        _saved = false;
      });
    }
  }

  void _setupLogSavedState() {
    logDetailsBloc
        .getLogFromDatabase(widget.logId)
        .then((logShort) => setState(() {
              _saved = logShort != null;
            }));
  }
}

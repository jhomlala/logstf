import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/bloc/logs_saved_bloc.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/util/error_handler.dart';
import 'package:logstf/view/log/log_general_stats_view.dart';
import 'package:logstf/view/log/log_players_view.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/progress_bar.dart';

import 'package:logstf/view/log/log_awards_view.dart';

import 'log_players_stats_matrix_view.dart';
import 'log_timeline_view.dart';

class LogView extends StatefulWidget {
  final int logId;
  final int selectePlayerSteamId;
  const LogView({Key key, this.logId, this.selectePlayerSteamId}) : super(key: key);

  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _appBarTitle = "General stats";
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    logDetailsBloc.init();
    logDetailsBloc.selectLog(widget.logId);

    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_onTabChanged);
    _setupLogSavedState();
  }

  @override
  void dispose() {
    logDetailsBloc.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    var index = _tabController.index;
    var tabName = "";
    switch (index) {
      case 0:
        tabName = "General stats";
        break;
      case 1:
        tabName = "Player stats";
        break;
      case 2:
        tabName = "Players matrix";
        break;
      case 3:
        tabName = "Awards stats";
        break;
      case 4:
        tabName = "Match timeline";
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
                  _onSaveClicked();
                },
              )
            ],
            bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(Icons.info_outline),
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                  ),
                  Tab(
                    icon: Icon(Icons.apps),
                  ),
                  Tab(
                    icon: Icon(Icons.flash_on),
                  ),
                  Tab(
                    icon: Icon(Icons.timer),
                  ),
                ])),
        body: StreamBuilder<Log>(
            stream: logDetailsBloc.logSubject,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("Error: " + snapshot.error.toString());
                return Container(
                    color: Theme.of(context).primaryColor,
                    child: EmptyCard(
                      description: ErrorHandler.handleError(snapshot.error, context),
                      retry: true,
                      retryAction: _onRetryPressed,
                    ));
              }
              if (snapshot.hasData) {
                return TabBarView(controller: _tabController, children: [
                  LogGeneralStatsView(),
                  LogPlayersView(widget.selectePlayerSteamId),
                  LogPlayersStatsMatrixView(),
                  LogAwardsView(),
                  LogTimelineView(),
                ]);
              } else {
                return Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                        child: Container(height: 40, child: ProgressBar())));
              }
            }));
  }

  void _onSaveClicked() async {
    Log log = logDetailsBloc.logSubject.value;
    var savedLog = await logDetailsBloc.getLogFromDatabase(log.id);
    LogShort logShort = log.setupShortLog();
    if (savedLog == null) {
      _saveLog(logShort);
    } else {
      _removeSavedLog(log, logShort);
    }
  }

  void _removeSavedLog(Log log, LogShort logShort) {
    logDetailsBloc.deleteLogFromDatabase(log.id);
    logsSavedBloc.removeLog(logShort);
    setState(() {
      _saved = false;
    });
  }

  void _saveLog(LogShort logShort) {
    logDetailsBloc.createLogInDatabase(logShort);
    logsSavedBloc.addLog(logShort);
    setState(() {
      _saved = true;
    });
  }

  void _setupLogSavedState() {
    logDetailsBloc
        .getLogFromDatabase(widget.logId)
        .then((logShort) => setState(() {
              _saved = logShort != null;
            }));
  }

  _onRetryPressed() {
    logDetailsBloc.selectLog(widget.logId);
  }
}

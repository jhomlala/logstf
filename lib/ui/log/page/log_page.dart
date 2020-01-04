import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/internal/log_saved_event.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/search_player_matches_navigation_event.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/util/routing_helper.dart';
import 'package:logstf/ui/log/bloc/log_details_bloc.dart';

import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/util/error_handler.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:logstf/ui/common/base_page_state.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/ui/log/fragment/log_awards_fragment.dart';
import 'package:logstf/ui/log/fragment/log_general_stats_fragment.dart';
import 'package:logstf/ui/log/fragment/log_players_fragment.dart';
import 'package:logstf/ui/common/widget/empty_card.dart';
import 'package:logstf/ui/common/widget/progress_bar.dart';

import 'package:sailor/sailor.dart';

import '../fragment/log_players_stats_matrix_fragment.dart';
import '../fragment/log_timeline_fragment.dart';

class LogPage extends BasePage {
  final LogDetailsBloc logDetailsBloc;

  const LogPage(Sailor sailor, this.logDetailsBloc) : super(sailor: sailor);

  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends BasePageState<LogPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _appBarTitle = "";
  bool _saved = false;
  int _logId;
  int _selectedPlayerSteamId;

  @override
  void didChangeDependencies() {
    if (!initCompleted) {
      _logId = Sailor.param<int>(context, AppConst.logIdParameter);
      _selectedPlayerSteamId =
          Sailor.param<int>(context, AppConst.selectedPlayerSteamId);
      initOnDependenciesProvided();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void initOnDependenciesProvided() async {
    super.initOnDependenciesProvided();
    logDetailsBloc.init();
    logDetailsBloc.selectLog(_logId);
    _setupLogSavedState();
  }

  @override
  void dispose() {
    logDetailsBloc.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    var applicationLocalization = ApplicationLocalization.of(context);
    var index = _tabController.index;
    var tabName = "";
    switch (index) {
      case 0:
        tabName = applicationLocalization.getText("log_general_stats");
        break;
      case 1:
        tabName = applicationLocalization.getText("log_players_stats");
        break;
      case 2:
        tabName = applicationLocalization.getText("log_players_matrix");
        break;
      case 3:
        tabName = applicationLocalization.getText("log_awards_stats");
        break;
      case 4:
        tabName = applicationLocalization.getText("log_match_timeline");
        break;
    }
    setState(() {
      _appBarTitle = tabName;
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupDefaultAppBarTitle(context);
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
                      description:
                          ErrorHandler.handleError(snapshot.error, context),
                      retry: true,
                      retryAction: _onRetryPressed,
                    ));
              }
              if (snapshot.hasData) {
                Log log = snapshot.data;
                return TabBarView(controller: _tabController, children: [
                  LogGeneralStatsFragment(log),
                  LogPlayersFragment(log, _selectedPlayerSteamId, _onPlayerClicked),
                  LogPlayersStatsMatrixFragment(log),
                  LogAwardsFragment(log),
                  LogTimelineFragment(log),
                ]);
              } else {
                return Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                        child: Container(height: 40, child: ProgressBar())));
              }
            }));
  }

  void _setupDefaultAppBarTitle(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    if (_appBarTitle == "") {
      _appBarTitle = applicationLocalization.getText("log_general_stats");
    }
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
    RxBus.post(LogSavedEvent(logShort, false));
    setState(() {
      _saved = false;
    });
  }

  void _saveLog(LogShort logShort) {
    logDetailsBloc.createLogInDatabase(logShort);
    RxBus.post(LogSavedEvent(logShort, true));
    setState(() {
      _saved = true;
    });
  }

  void _setupLogSavedState() {
    logDetailsBloc.getLogFromDatabase(_logId).then((logShort) => setState(() {
          _saved = logShort != null;
        }));
  }

  _onRetryPressed() {
    logDetailsBloc.selectLog(_logId);
  }

  void _onPlayerClicked(Log log, Player player,
      HashMap<String, AveragePlayerStats> averagePlayersStatsMap) async {
    print("1Average player stats map: " + averagePlayersStatsMap.toString());
    SearchPlayerMatchesNavigationEvent searchPlayerMatchesNavigationEvent =
        await getNavigator().navigate(RoutingHelper.logPlayerPageRoute, params: {
      AppConst.logParameter: log,
      AppConst.playerParameter: player,
      AppConst.averagePlayersStatsMapParameter: averagePlayersStatsMap
    });
    if (searchPlayerMatchesNavigationEvent != null) {
      getNavigator().pop(searchPlayerMatchesNavigationEvent);
    }
  }
}

class LogViewProvider extends PageProvider<LogPage> {
  final Sailor sailor;
  final LogDetailsBloc logDetailsBloc;

  LogViewProvider(
    this.sailor,
    this.logDetailsBloc,
  );

  @override
  LogPage create() {
    return LogPage(
      sailor,
      logDetailsBloc,
    );
  }
}

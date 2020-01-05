import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/internal/average_player_stats.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/model/internal/search_player_matches_event.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:logstf/ui/common/base_page_state.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/ui/player/bloc/log_player_player_fragment_bloc.dart';
import 'package:logstf/ui/player/fragment/log_player_class_compare_fragment.dart';
import 'package:logstf/ui/player/fragment/log_player_general_fragment.dart';
import 'package:sailor/sailor.dart';

import '../fragment/log_player_awards_fragment.dart';
import '../fragment/log_player_class_fragment.dart';
import '../fragment/log_player_kills_fragment.dart';
import '../fragment/log_player_player_fragment.dart';

class LogPlayerPage extends BasePage {
  final Sailor sailor;
  final LogPlayerPlayerFragmentBloc logPlayerPlayerFragmentBloc;

  LogPlayerPage(this.sailor, this.logPlayerPlayerFragmentBloc)
      : super(sailor: sailor);

  @override
  _LogPlayerPageState createState() => _LogPlayerPageState();
}

class _LogPlayerPageState extends BasePageState<LogPlayerPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _appBarTitle = "";
  Log log;
  Player player;
  HashMap<String, AveragePlayerStats> averagePlayersStatsMap;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(_onTabChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initCompleted) {
      log = Sailor.param<Log>(context, AppConst.logParameter);
      player = Sailor.param<Player>(context, AppConst.playerParameter);
      averagePlayersStatsMap =
          Sailor.param<HashMap<String, AveragePlayerStats>>(
              context, AppConst.averagePlayersStatsMapParameter);
      initCompleted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupDefaultAppBarTitle();
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        elevation: 0.0,
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(
                icon: Icon(Icons.info_outline),
              ),
              Tab(
                icon: Icon(Icons.highlight),
              ),
              Tab(
                icon: Icon(Icons.swap_horiz),
              ),
              Tab(
                icon: Icon(Icons.location_searching),
              ),
              Tab(
                icon: Icon(Icons.flash_on),
              )
            ]),
      ),
      body: Container(
          child: TabBarView(controller: _tabController, children: [
        LogPlayerPlayerFragment(player, log, widget.logPlayerPlayerFragmentBloc,
            _onSearchPlayerLogsClicked),
        LogPlayerGeneralFragment(player, averagePlayersStatsMap, log.length),
        LogPlayerClassOverviewFragment(log, player),
        LogPlayerClassCompareFragment(log, player),
        LogPlayerKillsFragment(log, player),
        LogPlayerAwardsFragment(log, player)
      ])),
    );
  }

  void _onTabChanged() {
    var applicationLocalization = ApplicationLocalization.of(context);
    int index = _tabController.index;
    String playerName = log.getPlayerName(player.steamId);
    var tabName = "";
    switch (index) {
      case 0:
        tabName =
            "$playerName - ${applicationLocalization.getText("log_player_player_overview")}";
        break;
      case 1:
        tabName =
            "$playerName - ${applicationLocalization.getText("log_player_general_stats")}";
        break;
      case 2:
        tabName =
            "$playerName - ${applicationLocalization.getText("log_player_class_overview")}";
        break;
      case 3:
        tabName =
            "$playerName - ${applicationLocalization.getText("log_player_class_compare")}";
        break;
      case 4:
        tabName =
            "$playerName - ${applicationLocalization.getText("log_player_match_matrix")}";
        break;
      case 5:
        tabName =
            "$playerName - ${applicationLocalization.getText("log_player_awards")}";
        break;
    }
    setState(() {
      _appBarTitle = tabName;
    });
  }

  void _setupDefaultAppBarTitle() {
    _onTabChanged();
  }

  void _onSearchPlayerLogsClicked(String steamId64) {
    getNavigator().pop(SearchPlayerMatchesEvent(steamId64));
  }
}

class LogPlayerPageProvider extends PageProvider<LogPlayerPage> {
  final Sailor sailor;
  final LogPlayerPlayerFragmentBloc logPlayerPlayerFragmentBloc;

  LogPlayerPageProvider(this.sailor, this.logPlayerPlayerFragmentBloc);

  @override
  LogPlayerPage create() {
    return LogPlayerPage(sailor, logPlayerPlayerFragmentBloc);
  }
}

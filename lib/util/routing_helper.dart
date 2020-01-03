import 'dart:collection';

import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/view/log/page/log_page.dart';
import 'package:logstf/view/player/page/log_player_page.dart';
import 'package:logstf/view/search/page/player_search_results_page.dart';
import 'package:logstf/view/search/page/search_page.dart';
import 'package:sailor/sailor.dart';

import 'app_const.dart';

class RoutingHelper {
  final Sailor sailor;
  final LogViewProvider logViewProvider;
  final SearchPageProvider searchPageProvider;
  final PlayerSearchResultsPageProvider playerSearchResultsPageProvider;
  final LogPlayerPageProvider logPlayerPageProvider;

  static const String logPageRoute = "/log";
  static const String searchPageRoute = "/search";
  static const String playerSearchResultsRoute = "/search/player/results";
  static const String logPlayerRoute = "/log/player";

  RoutingHelper(this.sailor, this.logViewProvider, this.searchPageProvider,
      this.playerSearchResultsPageProvider, this.logPlayerPageProvider);

  void setupRoutes() {
    print("Setup routes!");

    ///Log page
    sailor.addRoute(SailorRoute(
        name: logPageRoute,
        builder: (context, args, params) {
          return logViewProvider.create();
        },
        params: [
          SailorParam<int>(name: AppConst.logIdParameter, defaultValue: 0),
          SailorParam<int>(
              name: AppConst.selectedPlayerSteamId, defaultValue: 0)
        ]));

    ///Search page
    sailor.addRoute(SailorRoute(
        name: searchPageRoute,
        builder: (context, args, params) {
          return searchPageProvider.create();
        },
        params: [
          SailorParam<SearchData>(
              name: AppConst.searchDataParameter, defaultValue: null),
        ]));

    sailor.addRoute(SailorRoute(
        name: playerSearchResultsRoute,
        builder: (context, args, params) {
          return playerSearchResultsPageProvider.create();
        },
        params: [
          SailorParam<String>(
              name: AppConst.playerNameParameter, defaultValue: ""),
        ]));

    sailor.addRoute(SailorRoute(
        name: logPlayerRoute,
        builder: (context, args, params) {
          return logPlayerPageProvider.create();
        },
        params: [
          SailorParam<Log>(
              name: AppConst.logParameter),
          SailorParam<Player>(
              name: AppConst.playerParameter),
          SailorParam<HashMap<String, AveragePlayerStats>>(
              name: AppConst.averagePlayersStatsMapParameter),
        ]));
  }
}

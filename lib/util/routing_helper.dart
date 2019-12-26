import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:logstf/view/search/search_page.dart';
import 'package:sailor/sailor.dart';

import 'app_const.dart';

class RoutingHelper {
  final Sailor sailor;
  final LogViewProvider logViewProvider;
  final SearchPageProvider searchPageProvider;

  static const String logPageRoute = "/log";
  static const String searchPageRoute = "/search";

  RoutingHelper(this.sailor, this.logViewProvider, this.searchPageProvider);

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

    sailor.addRoute(SailorRoute(
        name: searchPageRoute,
        builder: (context, args, params) {
          return searchPageProvider.create();
        },
        params: [
          SailorParam<SearchData>(
              name: AppConst.searchDataParameter, defaultValue: null),
        ]));
  }
}

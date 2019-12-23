import 'package:logstf/view/log/log_view.dart';
import 'package:sailor/sailor.dart';

class RoutingHelper {
  final Sailor sailor;
  final LogViewProvider logViewProvider;

  static const String logPageRoute = "/log";

  RoutingHelper(this.sailor, this.logViewProvider);

  void setupRoutes() {
    print("Setup routes!");
    sailor.addRoute(SailorRoute(
        name: logPageRoute,
        builder: (context, args, params) {
          return logViewProvider.create();
        },
        params: [
          SailorParam<int>(name: "logId", defaultValue: 0),
          SailorParam<int>(name: "selectedPlayerSteamId", defaultValue: 0)
        ]));
  }
}

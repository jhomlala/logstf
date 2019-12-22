import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:sailor/sailor.dart';

class RoutingHelper {
  final Sailor sailor;
  final LogViewProvider logViewProvider;

  RoutingHelper(this.sailor, this.logViewProvider);

  void setupRoutes() {
    print("Setup routes!");
    sailor.addRoute(SailorRoute(
      name: "/logView",
      builder: (context, args, params) {
        return logViewProvider.create();
      },
    ));
  }
}

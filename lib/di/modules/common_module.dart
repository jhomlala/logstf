import 'package:inject/inject.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/util/routing_helper.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:logstf/view/search/search_page.dart';
import 'package:sailor/sailor.dart';

@module
class CommonModule {
  @provide
  @singleton
  Sailor provideSailor() {
    return Sailor();
  }

  @provide
  @singleton
  RoutingHelper provideRoutingHelper(Sailor sailor,
      LogViewProvider logViewProvider, SearchPageProvider searchPageProvider) {
    return RoutingHelper(sailor, logViewProvider, searchPageProvider);
  }

  @provide
  @singleton
  AppStateManager provideAppStateManager() {
    return AppStateManager();
  }
}

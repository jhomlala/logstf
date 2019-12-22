import 'dart:math';

import 'package:inject/inject.dart';
import 'package:logstf/util/routing_helper.dart';
import 'package:logstf/view/log/log_view.dart';
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
  RoutingHelper provideRoutingHelper(
      Sailor sailor, LogViewProvider logViewProvider) {
    return RoutingHelper(sailor, logViewProvider);
  }
}

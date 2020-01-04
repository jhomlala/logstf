
import 'package:inject/inject.dart';
import '../pocket_logs_app.dart';
import 'modules/bloc_module.dart';
import 'modules/common_module.dart';
import 'modules/page_module.dart';

import 'app_component.inject.dart' as g;
@Injector(const [PageModule, BlocModule, CommonModule])
abstract class AppComponent {
  @provide
  PocketLogsApp get app;

  static Future<AppComponent> create(PageModule pageModule,
      BlocModule blocModule, CommonModule commonModule) async {
    return await g.AppComponent$Injector.create(
        pageModule, blocModule, commonModule);
  }
}

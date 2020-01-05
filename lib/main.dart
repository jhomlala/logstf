import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'di/app_component.dart';
import 'di/modules/bloc_module.dart';
import 'di/modules/common_module.dart';
import 'di/modules/page_module.dart';

void main() async {
  if (!kReleaseMode) {
    Fimber.plantTree(DebugTree());
  }
  WidgetsFlutterBinding.ensureInitialized();
  var appComponent =
      await AppComponent.create(PageModule(), BlocModule(), CommonModule());
  runApp(appComponent.app);
}

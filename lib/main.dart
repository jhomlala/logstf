import 'package:flutter/material.dart';

import 'di/app_component.dart';
import 'di/modules/bloc_module.dart';
import 'di/modules/common_module.dart';
import 'di/modules/page_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appComponent =
      await AppComponent.create(PageModule(), BlocModule(), CommonModule());
  runApp(appComponent.app);
}

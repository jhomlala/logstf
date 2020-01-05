import 'package:flutter/material.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:sailor/sailor.dart';

abstract class BasePageState<T extends BasePage> extends State<T> {
  ///Flag to keep information about init completion
  bool initCompleted = false;

  Sailor getNavigator() {
    return widget.sailor;
  }

  void initOnDependenciesProvided() {
    initCompleted = true;
  }
}

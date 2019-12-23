import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

abstract class BasePage extends StatefulWidget {
  final Sailor sailor;

  const BasePage({Key key, this.sailor}) : super(key: key);
}

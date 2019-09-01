import 'package:flutter/material.dart';

class ClassIcon extends StatelessWidget {
  final String playerClass;
  final double width;
  final double height;

  const ClassIcon(
      {Key key, this.playerClass, this.width = 20, this.height = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _getClassIcon(playerClass),
      height: height,
      width: width,
    );
  }

  String _getClassIcon(String className) {
    switch (className) {
      case "scout":
        return "assets/scout.png";
      case "soldier":
        return "assets/soldier.png";
      case "pyro":
        return "assets/pyro.png";
      case "heavyweapons":
        return "assets/heavy.png";
      case "demoman":
        return "assets/demoman.png";
      case "engineer":
        return "assets/engineer.png";
      case "medic":
        return "assets/medic.png";
      case "spy":
        return "assets/spy.png";
      case "sniper":
        return "assets/sniper.png";
    }
    return "assets/scout.png";
  }
}

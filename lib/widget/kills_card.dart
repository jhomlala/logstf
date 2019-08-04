import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KillsCard extends StatelessWidget {
  final String className;
  final int kills;
  final int totalClassDeaths;

  const KillsCard({Key key, this.className, this.kills, this.totalClassDeaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var killsValue = kills;
    if (killsValue == null) {
      killsValue = 0;
    }
    double percentage = 0;
    if (killsValue != 0) {
      percentage = (killsValue / totalClassDeaths) * 100;
    }

    var opacity = killsValue == 0 ? 0.5 : 1.0;

    return Card(
        child: Opacity(
            opacity: opacity,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Image.asset(
                  _getClassIcon(className),
                  height: 30,
                  width: 30,
                ),
                Text(
                  "${_getClassNameFormatted(className)} Kills",
                  style: TextStyle(fontSize: 20),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "${_getClassNameFormatted(className)}(s)",
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: " was killed "),
                      TextSpan(
                          text: "$killsValue times",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: " which is "),
                      TextSpan(
                          text: "${percentage.toStringAsFixed(2)}%",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " of all $className deaths from opposite team."),
                    ],
                  ),
                ),
              ]),
            )));
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

  String _getClassNameFormatted(String className) {
    return className[0].toUpperCase() + className.substring(1);
  }
}

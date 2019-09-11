import 'package:flutter/material.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/widget/weapon_stats_widget.dart';

abstract class BaseOverviewCard extends StatefulWidget{

}

abstract class BaseOverviewCardState<T extends BaseOverviewCard> extends State<T>{
  String getTimePlayed(ClassStats classStats) {
    int seconds = classStats.totalTime;
    int minutes = (seconds / 60).floor();
    int secondsLeft = seconds - minutes * 60;
    String minutesFormatted = minutes < 10 ? "0$minutes" : minutes.toString();
    String secondsFormatted =
    secondsLeft < 10 ? "0$secondsLeft" : secondsLeft.toString();
    return "$minutesFormatted:$secondsFormatted";
  }

  Widget getStatRow(String name, String value) {
    return Row(children: [
      Text(name),
      Text(
        value,
        style: TextStyle(fontWeight: FontWeight.w700),
      )
    ]);
  }

  Widget getPositionRow(int position, String name, BuildContext context) {
    Color color = Theme
        .of(context)
        .textTheme
        .body1
        .color;
    if (position == 1) {
      color = Colors.yellow;
    }
    if (position == 2) {
      color = Colors.grey;
    } else if (position == 3) {
      color = Colors.deepOrangeAccent;
    }

    return Row(children: [
      Text("  ("),
      Text(
        "#$position",
        style: TextStyle(color: color),
      ),
      Text(" $name)")
    ]);
  }

  List<Widget> getWeaponWidgets(ClassStats classStats) {
    List<Widget> widgets = List();
    var weapons = classStats.weapon.entries.toList();
    weapons.sort((weapon1, weapon2) {
      return weapon2.value.dmg.compareTo(weapon1.value.dmg);
    });

    weapons.forEach((entry) {
      widgets.add(WeaponStatsWidget(entry.key, entry.value));
    });
    return widgets;
  }
}


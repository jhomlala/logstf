import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/weapon.dart';

class WeaponStatsWidget extends StatelessWidget {
  final String name;
  final Weapon weapon;

  const WeaponStatsWidget(this.name, this.weapon);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Image.network(
            _getWeaponImage(),
            height: 100,
            width: 100,
          ),
          Text(
            _getWeaponName(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Text("Kills: ${weapon.kills}"),
          Text("DA: ${weapon.dmg}"),
          Text("Avg DA: ${_getAvgDmg(weapon).toStringAsFixed(2)}"),
          Text("Shots: ${weapon.shots}"),
          Text("Hits: ${weapon.hits}"),
          Text("Accuracy: ${_getAccuracy(weapon).toStringAsFixed(2)}%")
        ]));
  }

  double _getAvgDmg(Weapon weapon) {
    if (weapon.avgDmg is int) {
      int avgDmg = weapon.avgDmg;
      return avgDmg.toDouble();
    }

    return weapon.avgDmg as double;
  }

  double _getAccuracy(Weapon weapon) {
    double accuracy = weapon.hits / weapon.shots * 100;
    if (accuracy.isNaN) {
      return 0;
    } else {
      return accuracy;
    }
  }

  String _getWeaponName() {
    print("Weapon name: " + name);
    return LogHelper.getWeaponName(name);
  }

  String _getWeaponImage() {
    return LogHelper.getWeaponImage(name);
  }
}

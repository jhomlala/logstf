import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/weapon.dart';
import 'package:logstf/util/application_localization.dart';

class WeaponStatsWidget extends StatelessWidget {
  final String name;
  final Weapon weapon;

  const WeaponStatsWidget(this.name, this.weapon);

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
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
          Padding(padding: EdgeInsets.only(top:5),),
          _getStatRow("${applicationLocalization.getText("log_kills")}: ", weapon.kills.toString()),
          _getStatRow("${applicationLocalization.getText("log_damage")}: ", weapon.dmg.toString()),
          _getStatRow("${applicationLocalization.getText("log_class_avg_da")}: ", _getAvgDmg(weapon).toStringAsFixed(2)),
          _getStatRow("${applicationLocalization.getText("log_class_shots")}: ", weapon.shots.toString()),
          _getStatRow("${applicationLocalization.getText("log_class_hits")}: ", weapon.hits.toString()),
          _getStatRow("${applicationLocalization.getText("log_class_accuracy")}: ", _getAccuracy(weapon).toStringAsFixed(2) + "%")
        ]));
  }
  Row _getStatRow(String name, String value){
    return Row(children: [Text(name), Text(value, style: TextStyle(fontWeight: FontWeight.bold),)]);
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
    return LogHelper.getWeaponName(name);
  }

  String _getWeaponImage() {
    return LogHelper.getWeaponImage(name);
  }
}

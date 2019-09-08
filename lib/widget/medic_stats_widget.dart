import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/medic_stats.dart';
import 'package:logstf/model/player.dart';

class MedicStatsWidget extends StatelessWidget {
  final Player player;
  final Log log;

  const MedicStatsWidget({Key key, this.player, this.log}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Table(
          defaultColumnWidth: IntrinsicColumnWidth(),
          children: getTableRows(),
        ));
  }


  List<TableRow> getTableRows() {
    var medicStats = player.medicStats;
    var uberTypes = player.ubertypes;
    List<TableRow> tableRows = List();
    tableRows.add(getTableRow("Healing", "${player.heal} HP"));
    tableRows.add(getTableRow("Charges", "${player.ubers} charge(s)"));
    tableRows.add(getTableRow("Heal/minute", "${_getHealPerMinute(player).toStringAsFixed(1)} HP"));
    tableRows.add(getTableRow("Heal/charge", "${_getHealPerCharge(player).toStringAsFixed(1)} HP"));
    tableRows.add(getTableRow("Drops", "${player.drops} drop(s)"));
    tableRows.add(getTableRow("Avg time to build",
        "${medicStats.avgTimeToBuild.toStringAsFixed(2)} second(s)"));
    tableRows.add(getTableRow("Avg time before using",
        "${medicStats.avgTimeBeforeUsing.toStringAsFixed(2)} second(s)"));
    tableRows.add(getTableRow(
        "Near full charge deaths", "${_getNearFullChargeDeaths(medicStats)} death(s)"));
    tableRows.add(getTableRow("Avg uber length",
        "${medicStats.avgUberLength.toStringAsFixed(2)} seconds"));
    tableRows.add(getTableRow("Avg uber recipients", "${_getAverageUberRecipients(medicStats)} player(s)"));
    tableRows.add(getTableRow("Deaths after charge",
        "${_getDeathsAfterCharge(medicStats)} death(s)"));
    tableRows.add(getTableRow(
        "Major advantages lost", "${medicStats.advantagesLost} advantage(s)"));
    tableRows.add(getTableRow("Biggest advantage lost",
        "${medicStats.biggestAdvantageLost} second(s)"));
    if (uberTypes.medigun != null) {
      tableRows.add(getTableRow("Medigun uber(s)", "${uberTypes.medigun}"));
    }
    if (uberTypes.kritzkrieg != null) {
      tableRows.add(getTableRow("Kritzkrieg uber(s)", "${uberTypes.kritzkrieg}"));
    }
    if (uberTypes.unknown != null) {
      tableRows.add(getTableRow("Other uber(s)", "${uberTypes.unknown}"));
    }

    return tableRows;
  }

  TableRow getTableRow(String name, String value) {
    return TableRow(children: [
      Text(
        name,
        style: TextStyle(fontSize: 16),
      ),
      Padding(
        padding: EdgeInsets.only(left: 40),
      ),
      Text(value, style: TextStyle(fontSize: 16))
    ]);
  }
  int _getNearFullChargeDeaths(MedicStats medicStats){
    return medicStats.deathsWith9599Uber != null ? medicStats.deathsWith9599Uber : 0;
  }

  int _getDeathsAfterCharge(MedicStats medicStats){
    return medicStats.deathsWithin20sAfterUber != null ? medicStats.deathsWithin20sAfterUber : 0;
  }

  String _getAverageUberRecipients(MedicStats medicStats){
    double avgUberLength = medicStats.avgUberLength;
    if (avgUberLength > 5.33){
      return "1-2";
    }
    else if (avgUberLength > 4){
      return "2-3";
    } else if (avgUberLength > 3.2){
      return "3-4";
    } else {
      return "4+";
    }
  }

  double _getHealPerCharge(Player player) {
    return player.heal / player.ubers;
  }

  _getHealPerMinute(Player player) {
    return player.heal/(log.length/60);
  }
}

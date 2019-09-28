import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/medic_stats.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/application_localization.dart';

class MedicStatsWidget extends StatelessWidget {
  final Player player;
  final Log log;

  const MedicStatsWidget({Key key, this.player, this.log}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Center(
            child: Table(
          columnWidths: {
            0: FractionColumnWidth(0.7),
            1: FractionColumnWidth(0.3),
          },
          children: getTableRows(context),
        )));
  }

  List<TableRow> getTableRows(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    var medicStats = player.medicStats;
    var uberTypes = player.ubertypes;

    List<TableRow> tableRows = List();
    if (medicStats == null) {
      tableRows.add(TableRow(children: [
        Text("${applicationLocalization.getText("log_class_no_medic_data")}")
      ]));
      return tableRows;
    }

    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_healing")}",
        "${player.heal} HP"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_charges")}",
        "${player.ubers} ${applicationLocalization.getText("log_class_medic_charges_charges")}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_hpm")}",
        "${_getHealPerMinute(player).toStringAsFixed(1)} HP"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_drops")}",
        "${player.drops} ${applicationLocalization.getText("log_class_medic_drops_drops")}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_avg_time_to_build")}",
        "${_getAvgTimeToBuild(medicStats, applicationLocalization)}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_avg_time_before_using")}",
        "${_getAvgTimeBeforeUsing(medicStats, applicationLocalization)}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_near_full")}",
        "${_getNearFullChargeDeaths(medicStats)} ${applicationLocalization.getText("log_class_medic_deaths_deaths")}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_avg_uber_length")}",
        "${medicStats.avgUberLength.toStringAsFixed(2)} ${applicationLocalization.getText("log_class_medic_seconds")}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_avg_uber_recipients")}",
        "${_getAverageUberRecipients(medicStats)} ${applicationLocalization.getText("log_class_medic_players")}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_deaths_after_charge")}",
        "${_getDeathsAfterCharge(medicStats)} ${applicationLocalization.getText("log_class_medic_deaths_deaths")}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_major_advantage_lost")}",
        "${medicStats.advantagesLost} ${applicationLocalization.getText("log_class_medic_advantages")}"));
    tableRows.add(getTableRow(
        "${applicationLocalization.getText("log_class_medic_biggest_advantage_lost")}",
        "${medicStats.biggestAdvantageLost} ${applicationLocalization.getText("log_class_medic_seconds")}"));
    if (uberTypes.medigun != null) {
      tableRows.add(getTableRow(
          "${applicationLocalization.getText("log_class_medic_medigun_ubers")}",
          "${uberTypes.medigun} ${applicationLocalization.getText("log_class_medic_ubers_ubers")}"));
    }
    if (uberTypes.kritzkrieg != null) {
      tableRows.add(getTableRow(
          "${applicationLocalization.getText("log_class_medic_kritzkrieg_ubers")}",
          "${uberTypes.kritzkrieg} ${applicationLocalization.getText("log_class_medic_ubers_ubers")}"));
    }
    if (uberTypes.unknown != null) {
      tableRows.add(getTableRow(
          "${applicationLocalization.getText("log_class_medic_other_ubers")}",
          "${uberTypes.unknown} ${applicationLocalization.getText("log_class_medic_ubers_ubers")}"));
    }

    return tableRows;
  }

  TableRow getTableRow(String name, String value) {
    return TableRow(children: [
      Text(
        name,
        style: TextStyle(fontSize: 14),
      ),
      Text(value, style: TextStyle(fontSize: 14))
    ]);
  }

  int _getNearFullChargeDeaths(MedicStats medicStats) {
    return medicStats.deathsWith9599Uber != null
        ? medicStats.deathsWith9599Uber
        : 0;
  }

  int _getDeathsAfterCharge(MedicStats medicStats) {
    return medicStats.deathsWithin20sAfterUber != null
        ? medicStats.deathsWithin20sAfterUber
        : 0;
  }

  String _getAverageUberRecipients(MedicStats medicStats) {
    double avgUberLength = medicStats.avgUberLength;
    if (avgUberLength > 5.33) {
      return "1-2";
    } else if (avgUberLength > 4) {
      return "2-3";
    } else if (avgUberLength > 3.2) {
      return "3-4";
    } else {
      return "4+";
    }
  }

  _getHealPerMinute(Player player) {
    return player.heal / (log.length / 60);
  }

  _getAvgTimeToBuild(
      MedicStats medicStats, ApplicationLocalization applicationLocalization) {
    if (medicStats != null) {
      return "${medicStats.avgTimeToBuild.toStringAsFixed(2)} ${medicStats.biggestAdvantageLost} ${applicationLocalization.getText("log_class_medic_seconds")})";
    } else {
      return "no data";
    }
  }

  _getAvgTimeBeforeUsing(
      MedicStats medicStats, ApplicationLocalization applicationLocalization) {
    if (medicStats != null) {
      return "${medicStats.avgTimeBeforeUsing.toStringAsFixed(2)} ${medicStats.biggestAdvantageLost} ${applicationLocalization.getText("log_class_medic_seconds")}";
    } else {
      return "no data";
    }
  }
}

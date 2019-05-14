import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/model/medic_stats.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/ubertypes.dart';

class MedicStatsWidget extends StatelessWidget {
  final Player player;

  const MedicStatsWidget({Key key, this.player}) : super(key: key);

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
    tableRows.add(getTableRow("Charges", "${player.ubers} Charges"));
    tableRows.add(getTableRow("Drops", "${player.drops} Drops"));
    tableRows.add(getTableRow("Avg time to build",
        "${medicStats.avgTimeToBuild.toStringAsFixed(2)} seconds"));
    tableRows.add(getTableRow("Avg time before using",
        "${medicStats.avgTimeBeforeUsing.toStringAsFixed(2)} seconds"));
    tableRows.add(getTableRow(
        "Near full charge deaths", "${medicStats.deathsWith9599Uber} deaths"));
    tableRows.add(getTableRow("Avg uber length",
        "${medicStats.avgUberLength.toStringAsFixed(2)} seconds"));
    tableRows.add(getTableRow("Deaths after charge",
        "${medicStats.deathsWithin20sAfterUber} deaths"));
    tableRows.add(getTableRow(
        "Major advantages lost", "${medicStats.advantagesLost} advantages"));
    tableRows.add(getTableRow("Biggest advantage lost",
        "${medicStats.biggestAdvantageLost} seconds"));
    if (uberTypes.medigun != null) {
      tableRows.add(getTableRow("Medigun ubers", "${uberTypes.medigun}"));
    }
    if (uberTypes.kritzkrieg != null) {
      tableRows.add(getTableRow("Kritzkrieg ubers", "${uberTypes.kritzkrieg}"));
    }
    if (uberTypes.unknown != null) {
      tableRows.add(getTableRow("Other ubers", "${uberTypes.unknown}"));
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
}

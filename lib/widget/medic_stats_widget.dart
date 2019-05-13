import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/model/medic_stats.dart';
import 'package:logstf/model/ubertypes.dart';

class MedicStatsWidget extends StatelessWidget {
  final MedicStats medicStats;
  final Ubertypes ubertypes;

  const MedicStatsWidget({Key key, this.medicStats, this.ubertypes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Table(
          defaultColumnWidth: FractionColumnWidth(0.5),
          children: getTableRows(),
        ));
  }

  List<TableRow> getTableRows() {
    List<TableRow> tableRows = List();
    tableRows.add(getTableRow("Healing", 1000));
    tableRows.add(getTableRow("Charges", 100));
    tableRows.add(getTableRow("Drops", 1));
    tableRows.add(getTableRow("Avg time to build", 100));
    tableRows.add(getTableRow("Avg time before using", 1));
    tableRows.add(getTableRow("Near full charge deaths",1));
    tableRows.add(getTableRow("Avg uber length",1));
    tableRows.add(getTableRow("Deaths after charge", 3));
    tableRows.add(getTableRow("Major advantages lost", 0));
    tableRows.add(getTableRow("Biggest advantage lost",0));
    tableRows.add(
        getTableRow("Advantages lost", medicStats.advantagesLost.toDouble()));

    return tableRows;
  }

  TableRow getTableRow(String description, double value) {
    return TableRow( 
        children: [Text(description, style: TextStyle(fontSize: 16),), Text(value.toStringAsFixed(2), style: TextStyle(fontSize: 16))]);
  }
}

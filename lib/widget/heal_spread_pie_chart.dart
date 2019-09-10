import 'package:flutter/material.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:pie_chart/pie_chart.dart';

import 'class_icon.dart';

class HealSpreadPieChart extends StatefulWidget {
  final List<HealSpread> healSpreadList;

  const HealSpreadPieChart({Key key, this.healSpreadList}) : super(key: key);

  @override
  _HealSpreadPieChartState createState() => _HealSpreadPieChartState();
}

class _HealSpreadPieChartState extends State<HealSpreadPieChart> {
  List<Color> colorList = List();

  @override
  void initState() {
    colorList.addAll([
      Colors.red,
      Colors.green,
      Colors.deepPurple,
      Colors.lime,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.blue,
      Colors.brown,
      Colors.cyan,
      Colors.indigo,
      Colors.lime
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    widget.healSpreadList.forEach((healSpread) {
      dataMap[healSpread.name] = healSpread.percentage;
    });

    return Column(children: [
      PieChart(
        dataMap: dataMap,
        //Required parameter
        legendFontColor: Colors.blueGrey[900],
        legendFontSize: 12.0,
        legendFontWeight: FontWeight.w500,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 12.0,
        chartRadius: MediaQuery.of(context).size.width / 2,
        showChartValuesInPercentage: true,
        showChartValues: true,
        chartValuesColor: Colors.white,
        showLegends: false,
        colorList: colorList,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: getLegendWidgets(),
      )
    ]);
  }

  List<Widget> getLegendWidgets() {
    List<Widget> widgets = List();
    for (int index = 0; index < widget.healSpreadList.length; index++) {
      widgets.add(getLegendRow(widget.healSpreadList[index], colorList[index]));
    }

    return widgets;
  }

  Widget getLegendRow(HealSpread healSpread, Color color) {
    String playerName = healSpread.name;
    if (playerName.length > 20){
      playerName = playerName.substring(0,20) + "...";
    }

    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(color: color),
            ),
            _getClassesIconsRow(healSpread.classes),
            Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                 playerName,
                  overflow: TextOverflow.ellipsis,
                )),
            Container(

                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "${healSpread.percentage.toStringAsFixed(1)}% (${healSpread.health} HP)",
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ));
  }

  Widget _getClassesIconsRow(List<String> classes) {
    List<Widget> widgets = List();
    classes.forEach(
        (playerClass) => widgets.add(ClassIcon(playerClass: playerClass)));

    return Row(children: widgets);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logstf/model/class_kill.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/ui/common/widget/class_icon.dart';
import 'package:marquee/marquee.dart';

class LogPlayersStatsMatrixFragment extends StatefulWidget {
  final Log log;

  const LogPlayersStatsMatrixFragment(this.log);

  @override
  _LogPlayersStatsMatrixState createState() => _LogPlayersStatsMatrixState();
}

class _LogPlayersStatsMatrixState extends State<LogPlayersStatsMatrixFragment> {
  Log get _log => widget.log;
  Map<String, Player> _players;
  Map<String, String> _playerNames;
  List<MapEntry<String, ClassKill>> _currentStatsList;
  List<String> _dropdownValues;
  String _statType = "";

  @override
  void initState() {
    _players = _log.players;
    _playerNames = _log.names;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    _setupDropdownValues(applicationLocalization);
    return Container(
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
          child: Column(children: [
        Card(
            child: Row(
          children: [
            Center(
                child: Text(
              "${applicationLocalization.getText("log_stats")}  ",
              style: TextStyle(fontSize: 16.0),
            )),
            _getStatDropdownWidget(applicationLocalization)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )),
        Card(
            child: Container(
                color: Theme.of(context).primaryColor,
                margin: EdgeInsets.all(0),
                child: Table(columnWidths: {
                  0: FractionColumnWidth(0.2),
                }, children: _getTableRows(applicationLocalization))))
      ])),
    );
  }

  void _setupDropdownValues(ApplicationLocalization applicationLocalization) {
    if (_dropdownValues == null || _dropdownValues.isEmpty) {
      _dropdownValues = List();
      _dropdownValues.add(applicationLocalization.getText("log_kills"));
      _dropdownValues
          .add(applicationLocalization.getText("log_kills_and_assists"));
      _dropdownValues.add(applicationLocalization.getText("log_deaths"));
      _onStatTypeChanged(_dropdownValues[0]);
    }
  }

  List<TableRow> _getTableRows(
      ApplicationLocalization applicationLocalization) {
    List<TableRow> rows = List();
    rows.add(_getHeaderRow(applicationLocalization));
    _currentStatsList.forEach((MapEntry<String, ClassKill> entry) {
      rows.add(_getRow(entry.key, entry.value));
    });
    return rows;
  }

  int _sumStats(ClassKill classKill) {
    return classKill.scout +
        classKill.soldier +
        classKill.pyro +
        classKill.demoman +
        classKill.heavyweapons +
        classKill.engineer +
        classKill.medic +
        classKill.sniper +
        classKill.spy;
  }

  TableRow _getRow(String steamId, ClassKill classKill) {
    List<Widget> widgets = List();
    widgets.add(_getPlayerNameWidget(_players[steamId]));
    widgets.add(_getCellValue(classKill.scout));
    widgets.add(_getCellValue(classKill.soldier));
    widgets.add(_getCellValue(classKill.pyro));
    widgets.add(_getCellValue(classKill.demoman));
    widgets.add(_getCellValue(classKill.heavyweapons));
    widgets.add(_getCellValue(classKill.engineer));
    widgets.add(_getCellValue(classKill.medic));
    widgets.add(_getCellValue(classKill.sniper));
    widgets.add(_getCellValue(classKill.spy));
    widgets.add(_getCellValue(_sumStats(classKill)));

    return TableRow(children: widgets);
  }

  Widget _getCellValue(int value) {
    return Container(
        color: AppUtils.getBackgroundColor(context),
        height: 30,
        child: Center(child: Text(value.toString())));
  }

  Widget _getHeader(Widget child, Function onClicked,
      {bool rightCorner = false}) {
    BoxDecoration decoration;
    if (rightCorner) {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
        color: AppUtils.darkBlueColor,
      );
    } else {
      decoration = BoxDecoration(
        color: AppUtils.darkBlueColor,
      );
    }

    return InkWell(
        onTap: () {
          onClicked();
        },
        child: Container(
            decoration: decoration,
            height: 30,
            child: Padding(padding: EdgeInsets.all(5), child: child)));
  }

  Widget _getTextHeader(String text, {bool rightCorner = false}) {
    return _getHeader(
        Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white),
        )), () {
      _sortCurrentStatsByClass("all");
    }, rightCorner: rightCorner);
  }

  Widget _getClassHeader(String className, {bool rightCorner = false}) {
    return _getHeader(
        ClassIcon(
          playerClass: className,
        ), () {
      _onClassClicked(className);
    });
  }

  TableRow _getHeaderRow(ApplicationLocalization applicationLocalization) {
    List<Widget> widgets = List();
    widgets.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
          color: AppUtils.darkBlueColor,
        ),
        height: 30,
        child: Center(
            child: Text(
          applicationLocalization.getText("log_player"),
          style: TextStyle(color: Colors.white),
        ))));
    widgets.add(_getClassHeader("scout"));
    widgets.add(_getClassHeader("soldier"));
    widgets.add(_getClassHeader("pyro"));
    widgets.add(_getClassHeader("demoman"));
    widgets.add(_getClassHeader("heavyweapons"));
    widgets.add(_getClassHeader("engineer"));
    widgets.add(_getClassHeader("medic"));
    widgets.add(_getClassHeader("sniper"));
    widgets.add(_getClassHeader("spy"));
    widgets.add(_getTextHeader("T", rightCorner: true));
    return TableRow(children: widgets);
  }

  bool _isPlayerNameFitInColumn(String name) {
    double width = MediaQuery.of(context).size.width;
    double playerNameColumnWidth = width * 0.2 - 10;

    final constraints = BoxConstraints(
      maxWidth: playerNameColumnWidth,
      minHeight: 0.0,
      minWidth: 0.0,
    );

    double fontSize = 16;
    RenderParagraph renderParagraph = RenderParagraph(
        TextSpan(
          text: name,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    renderParagraph.layout(constraints);
    double textWidth =
        renderParagraph.getMinIntrinsicWidth(fontSize).ceilToDouble();
    return playerNameColumnWidth > textWidth;
  }

  Widget _getPlayerNameWidget(Player player) {
    String name = _playerNames[player.steamId];
    Color teamColor = Colors.red;
    if (player.team == "Blue") {
      teamColor = Colors.blue;
    }
    Widget widget;
    if (_isPlayerNameFitInColumn(name)) {
      widget = Center(
          child: Text(
        _playerNames[player.steamId],
        style: TextStyle(color: Colors.white),
      ));
    } else {
      widget = Marquee(
        text: name,
        scrollAxis: Axis.horizontal,
        style: TextStyle(color: Colors.white),
        crossAxisAlignment: CrossAxisAlignment.center,
        velocity: 20.0,
        blankSpace: 20.0,
      );
    }

    return Container(
        height: 30,
        decoration: BoxDecoration(
            color: teamColor,
            border: Border(
                bottom: BorderSide(color: AppUtils.getBorderColor(context)))),
        child: widget);
  }

  Widget _getStatDropdownWidget(
      ApplicationLocalization applicationLocalization) {
    return DropdownButton<String>(
      value: _statType,
      items: _dropdownValues.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        );
      }).toList(),
      onChanged: (value) {
        _onStatTypeChanged(value);
      },
    );
  }

  _onStatTypeChanged(String statType) {
    int index = _dropdownValues.indexOf(statType);

    if (index == 0) {
      _currentStatsList = _log.classKills.entries.toList();
    }
    if (index == 1) {
      _currentStatsList = _log.classKillAssists.entries.toList();
    }
    if (index == 2) {
      _currentStatsList = _log.classDeaths.entries.toList();
    }

    setState(() {
      _statType = statType;
    });
  }

  void _onClassClicked(String className) {
    _sortCurrentStatsByClass(className);
  }

  void _sortCurrentStatsByClass(String className) {
    var stats = _currentStatsList;
    if (className == "scout") {
      stats.sort((entry1, entry2) {
        return entry2.value.scout.compareTo(entry1.value.scout);
      });
    }
    if (className == "soldier") {
      stats.sort((entry1, entry2) {
        return entry2.value.soldier.compareTo(entry1.value.soldier);
      });
    }
    if (className == "pyro") {
      stats.sort((entry1, entry2) {
        return entry2.value.pyro.compareTo(entry1.value.pyro);
      });
    }
    if (className == "demoman") {
      stats.sort((entry1, entry2) {
        return entry2.value.demoman.compareTo(entry1.value.demoman);
      });
    }
    if (className == "heavyweapons") {
      stats.sort((entry1, entry2) {
        return entry2.value.heavyweapons.compareTo(entry1.value.heavyweapons);
      });
    }
    if (className == "engineer") {
      stats.sort((entry1, entry2) {
        return entry2.value.engineer.compareTo(entry1.value.engineer);
      });
    }
    if (className == "medic") {
      stats.sort((entry1, entry2) {
        return entry2.value.medic.compareTo(entry1.value.medic);
      });
    }
    if (className == "sniper") {
      stats.sort((entry1, entry2) {
        return entry2.value.sniper.compareTo(entry1.value.sniper);
      });
    }
    if (className == "spy") {
      stats.sort((entry1, entry2) {
        return entry2.value.spy.compareTo(entry1.value.spy);
      });
    }
    if (className == "all") {
      stats.sort((entry1, entry2) {
        return _sumStats(entry2.value).compareTo(_sumStats(entry1.value));
      });
    }
    setState(() {
      _currentStatsList = stats;
    });
  }
}

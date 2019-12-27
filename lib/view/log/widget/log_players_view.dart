import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logstf/helper/stats_manager.dart';

import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/navigation_event.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/search_player_matches_navigation_event.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/view/player/log_player_detailed_view.dart';
import 'package:logstf/widget/class_icon.dart';
import 'package:marquee/marquee.dart';

class LogPlayersView extends StatefulWidget {
  final Log log;
  final int selectedPlayerSteamId;

  const LogPlayersView(this.log,this.selectedPlayerSteamId);

  @override
  _LogPlayersViewState createState() => _LogPlayersViewState();
}

class _LogPlayersViewState extends State<LogPlayersView> {
  Log get _log => widget.log;
  Map<String, Player> _players;
  Map<String, String> _playerNames;
  HashMap<String, AveragePlayerStats> _averagePlayerStatsMap;
  List<Player> _playersSorted;
  String _currentFilter = "Kills";

  @override
  void initState() {
    init(context);
    super.initState();
  }

  void init(BuildContext context) {
    _players = _log.players;
    _playerNames = _log.names;
    var length = _log.length;
    _averagePlayerStatsMap = HashMap();
    _averagePlayerStatsMap["ALL"] =
        StatsManager.getAveragePlayerStatsForAllPlayers(
            _players.values.toList(), length);
    _averagePlayerStatsMap["Red"] = StatsManager.getAveragePlayerStatsForTeam(
        _players.values.toList(), length, "Red");
    _averagePlayerStatsMap["Blue"] = StatsManager.getAveragePlayerStatsForTeam(
        _players.values.toList(), length, "Blue");
    _playersSorted = _orderPlayersByField(_players.values.toList(), "Kills");
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
            child: Column(children: [
          Card(
              child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
                color: Theme.of(context).primaryColor,
                width: 120,
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(0.3),
                    1: FractionColumnWidth(0.7)
                  },
                  children: _getPlayerStickyRows(),
                )),
            Expanded(
                child: Container(
                    height: (_players.length + 1) * 30.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 14,
                      itemBuilder: (BuildContext context, int index) {
                        return _getPlayerValueColumn(index);
                      },
                    )))
          ])),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(applicationLocalization.getText("log_scroll_right_to_see_more"),
                style: TextStyle(color: Colors.white)),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            )
          ])
        ])));
  }

  void _onPlayerClicked(Player player) async {
    NavigationEvent navigationEvent = await Navigator.push<NavigationEvent>(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LogPlayerDetailedView(_log, player, _averagePlayerStatsMap)));

    if (navigationEvent != null &&
        navigationEvent is SearchPlayerMatchesNavigationEvent) {
      Navigator.pop(context, navigationEvent);
    }
  }

  List<Player> _orderPlayersByField(List<Player> players, String filterName) {
    List<Player> playersCopy = List();
    playersCopy.addAll(players);
    switch (filterName) {
      case "K":
        playersCopy
            .sort((player1, player2) => player2.kills.compareTo(player1.kills));
        break;
      case "D":
        playersCopy.sort(
            (player1, player2) => player2.deaths.compareTo(player1.deaths));
        break;
      case "A":
        playersCopy.sort(
            (player1, player2) => player2.assists.compareTo(player1.assists));
        break;
      case "DA":
        playersCopy
            .sort((player1, player2) => player2.dmg.compareTo(player1.dmg));
        break;

      case "DA/M":
        playersCopy
            .sort((player1, player2) => player2.dapm.compareTo(player1.dapm));
        break;
      case "KA/D":
        playersCopy.sort((player1, player2) =>
            double.parse(player2.kapd).compareTo(double.parse(player1.kapd)));
        break;
      case "K/D":
        playersCopy.sort((player1, player2) =>
            double.parse(player2.kpd).compareTo(double.parse(player1.kpd)));
        break;
      case "DT":
        playersCopy
            .sort((player1, player2) => player2.dt.compareTo(player1.dt));
        break;
      case "DT/M":
        playersCopy.sort((player1, player2) =>
            _calculateDamageTakenPerMinute(player2.dt)
                .compareTo(_calculateDamageTakenPerMinute(player1.dt)));
        break;
      case "HP":
        playersCopy.sort((player1, player2) =>
            player2.medkitsHp.compareTo(player1.medkitsHp));
        break;
      case "HS":
        playersCopy.sort((player1, player2) =>
            player2.headshots.compareTo(player1.headshots));
        break;
      case "AS":
        playersCopy
            .sort((player1, player2) => player2.as.compareTo(player1.as));
        break;
      case "CAP":
        playersCopy
            .sort((player1, player2) => player2.cpc.compareTo(player1.cpc));
        break;
      case "BA":
        playersCopy.sort((player1, player2) =>
            player2.backstabs.compareTo(player1.backstabs));
        break;
      case "Class":
        playersCopy.sort((player1, player2) =>
            getPlayerClass(player1).compareTo(getPlayerClass(player2)));
        break;
    }
    return playersCopy;
  }

  int getPlayerClass(Player player) {
    switch (player.classStats.first.type) {
      case "scout":
        return 1;
      case "soldier":
        return 2;
      case "pyro":
        return 3;
      case "demoman":
        return 4;
      case "heavyweapons":
        return 5;
      case "engineer":
        return 6;
      case "medic":
        return 7;
      case "sniper":
        return 8;
      case "spy":
        return 9;
    }
    return 0;
  }

  double _calculateDamageTakenPerMinute(int damgeTaken) {
    var length = _log.length / 60;
    return damgeTaken / length;
  }

  bool _isPlayerNameFitInColumn(String name) {
    double playerNameColumnWidth = 120;

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

  Widget _getPlayerClassesWidget(Player player, {bool selectedPlayer = false}) {
    List<Widget> widgets = List();
    var classStatsList = player.classStats;
    int additionalClasses = 0;
    if (classStatsList.length > 2) {
      additionalClasses = classStatsList.length - 2;
      classStatsList = classStatsList.sublist(0, 2);
    }

    classStatsList.forEach((classStats) {
      widgets.add(ClassIcon(playerClass: classStats.type));
    });

    if (additionalClasses != 0) {
      widgets.add(Text(" +$additionalClasses "));
    }
    Color color = AppUtils.getBackgroundColor(context);
    if (selectedPlayer) {
      color = Colors.teal;
    }
    return Container(
        color: color,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }

  List<TableRow> _getPlayerStickyRows() {
    var applicationLocalization = ApplicationLocalization.of(context);
    List<TableRow> rows = List();
    rows.add(TableRow(children: [
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
            color: AppUtils.darkBlueColor,
          ),
          height: 30,
          child: Center(
              child: Text(applicationLocalization.getText("log_player"),
                  style: TextStyle(color: Colors.white)))),
    ]));
    _playersSorted.forEach((Player player) {
      rows.add(_getPlayerStickyRow(player));
    });
    return rows;
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
        decoration: BoxDecoration(
            color: teamColor,
            border: Border(
                bottom: BorderSide(color: AppUtils.getBorderColor(context)))),
        height: 30,
        width: 100,
        child: widget);
  }

  TableRow _getPlayerStickyRow(Player player) {
    return TableRow(children: [
      InkWell(
          onTap: () {
            _onPlayerClicked(player);
          },
          child: _getPlayerNameWidget(player)),
    ]);
  }

  Widget _getClassesColumn(List<Player> players) {
    var applicationLocalization = ApplicationLocalization.of(context);
    List<Widget> columnWidgets = List();
    columnWidgets.add(_getHeaderCell(
        applicationLocalization.getText("log_class"),
        headerValue: "Class"));

    int selectedPlayerIndex = _getSelectedPlayerIndex();
    for (int index = 0; index < players.length; index++) {
      Player player = players[index];

      columnWidgets.add(Container(
          height: 30,
          width: 65,
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppUtils.getBorderColor(context))),
          ),
          child: _getPlayerClassesWidget(player,
              selectedPlayer: selectedPlayerIndex == index)));
    }

    return Column(children: columnWidgets);
  }

  int getSelectedPlayerIndex() {
    int playerIndex = 0;
    for (int index = 0; index < _playersSorted.length; index++) {
      if (widget.selectedPlayerSteamId ==
          AppUtils.convertSteamId3ToSteamId64(_playersSorted[index].steamId)) {
        playerIndex = index;
      }
    }
    return playerIndex;
  }

  Widget _getPlayerValueColumn(int index) {
    if (index == 0) {
      return _getClassesColumn(_playersSorted);
    }
    if (index == 1) {
      return _getValuesColumn(
          "K",
          _playersSorted.map<String>((Player player) {
            return player.kills.toString();
          }).toList(),
          width: 40);
    }

    if (index == 2) {
      return _getValuesColumn(
          "A",
          _playersSorted.map<String>((Player player) {
            return player.assists.toString();
          }).toList(),
          width: 40);
    }
    if (index == 3) {
      return _getValuesColumn(
          "D",
          _playersSorted.map<String>((Player player) {
            return player.deaths.toString();
          }).toList(),
          width: 40);
    }
    if (index == 4) {
      return _getValuesColumn(
          "DA",
          _playersSorted.map<String>((Player player) {
            return player.dmg.toString();
          }).toList(),
          width: 50);
    }
    if (index == 5) {
      return _getValuesColumn(
          "DA/M",
          _playersSorted.map<String>((Player player) {
            return player.dapm.toString();
          }).toList());
    }
    if (index == 6) {
      return _getValuesColumn(
          "KA/D",
          _playersSorted.map<String>((Player player) {
            return player.kapd;
          }).toList());
    }
    if (index == 7) {
      return _getValuesColumn(
          "K/D",
          _playersSorted.map<String>((Player player) {
            return player.kpd.toString();
          }).toList());
    }
    if (index == 8) {
      return _getValuesColumn(
          "DT",
          _playersSorted.map<String>((Player player) {
            return player.dt.toString();
          }).toList(),
          width: 50);
    }
    if (index == 9) {
      return _getValuesColumn(
          "DT/M",
          _playersSorted.map<String>((Player player) {
            return _calculateDamageTakenPerMinute(player.dt).toStringAsFixed(0);
          }).toList());
    }
    if (index == 10) {
      return _getValuesColumn(
          "HP",
          _playersSorted.map<String>((Player player) {
            return player.medkitsHp.toString();
          }).toList(),
          width: 50);
    }
    if (index == 11) {
      return _getValuesColumn(
          "HS",
          _playersSorted.map<String>((Player player) {
            return player.headshots.toString();
          }).toList(),
          width: 50);
    }
    if (index == 12) {
      return _getValuesColumn(
          "AS",
          _playersSorted.map<String>((Player player) {
            return player.as.toString();
          }).toList(),
          width: 50);
    }
    if (index == 13) {
      return _getValuesColumn(
          "CAP",
          _playersSorted.map<String>((Player player) {
            return player.cpc.toString();
          }).toList());
    }

    if (index == 14) {
      return _getValuesColumn(
          "BA",
          _playersSorted.map<String>((Player player) {
            return player.backstabs.toString();
          }).toList(),
          rightCorner: true);
    }

    return Container(
      width: 0,
      height: 0,
    );
  }

  int _getSelectedPlayerIndex() {
    int playerIndex = -1;
    var players = _players.entries.toList();
    for (int index = 0; index < players.length; index++) {
      var entry = players[index];
      String steamId = entry.key;
      if (AppUtils.convertSteamId3ToSteamId64(steamId) ==
          widget.selectedPlayerSteamId) {
        playerIndex = index;
      }
    }

    return playerIndex;
  }

  Widget _getValuesColumn(String title, List<String> values,
      {bool rightCorner = false, double width = 65}) {
    List<Widget> columnWidgets = List();
    columnWidgets.add(_getHeaderCell(title, rightCorner: rightCorner));

    int selectedPlayerIndex = _getSelectedPlayerIndex();
    print("Selected player index: " + selectedPlayerIndex.toString());
    for (int index = 0; index < values.length; index++) {
      columnWidgets.add(_getPlayerValueCell(values[index],
          width: width, selectedPlayer: index == selectedPlayerIndex));
    }

    return Container(width: width, child: Column(children: columnWidgets));
  }

  Widget _getHeaderCell(String value,
      {bool rightCorner = false, String headerValue}) {
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

    List<Widget> widgets = List();
    if (_currentFilter == value ||
        (_currentFilter != null && _currentFilter == headerValue)) {
      widgets.add(Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ));
    }
    widgets.add(Text(value, style: TextStyle(color: Colors.white)));

    return InkWell(
        onTap: () {
          var clickValue = headerValue;
          if (clickValue == null) {
            clickValue = value;
          }
          _onHeaderClicked(clickValue);
        },
        child: Container(
            decoration: decoration,
            height: 30,
            width: 65,
            child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widgets))));
  }

  Widget _getPlayerValueCell(String value,
      {double width = 65, bool selectedPlayer = false}) {
    Color color = AppUtils.getBackgroundColor(context);
    if (selectedPlayer) {
      color = Colors.teal;
    }

    return Container(
        decoration: BoxDecoration(
          color: color,
          border: Border(
              bottom: BorderSide(color: AppUtils.getBorderColor(context))),
        ),
        height: 30,
        width: width,
        child: Center(child: Text(value)));
  }

  _onHeaderClicked(String value) {
    print("header clicked: " + value);
    _playersSorted = _orderPlayersByField(_playersSorted, value);
    _currentFilter = value;
    setState(() {});
  }
}

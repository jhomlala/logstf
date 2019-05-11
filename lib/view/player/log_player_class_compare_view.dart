import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/widget/comparison_card.dart';

class LogPlayerClassCompareView extends StatefulWidget {
  final Log log;
  final Player player;

  const LogPlayerClassCompareView(this.log, this.player);

  @override
  _LogPlayerClassCompareViewState createState() =>
      _LogPlayerClassCompareViewState();
}

class _LogPlayerClassCompareViewState extends State<LogPlayerClassCompareView> {
  List<String> _classes;
  String _selectedClass;
  List<Player> _otherPlayersWithSelectedClass;
  Player _selectedPlayer;
  String _playerName;
  String _selectedPlayerName;

  @override
  void initState() {
    _classes = _getPlayerClasses();
    print("Classes: " + _classes.toString());
    _selectedClass = _classes[0];
    _otherPlayersWithSelectedClass = LogHelper.getOtherPlayersWithClass(
        widget.log, _selectedClass, widget.player.steamId);
    _selectedPlayer = _otherPlayersWithSelectedClass[0];
    _playerName = widget.log.getPlayerName(widget.player.steamId);
    _selectedPlayerName = widget.log.getPlayerName(_selectedPlayer.steamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: AppUtils.seashellColor),
        child: SingleChildScrollView(
            child:
                Container(child: Column(children: _getMainColumnWidgets()))));
  }

  List<Widget> _getMainColumnWidgets() {
    List<Widget> widgets = List();
    widgets.add(_getClassAndPlayerSelectionRow());
    widgets.addAll(_getComparisonWidgets());
    return widgets;
  }

  Row _getClassAndPlayerSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Class:",
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        _getClassesDropdown(),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Text("Compare:", style: TextStyle(fontSize: 16)),
        Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        _getPlayersDropdown()
      ],
    );
  }

  List<String> _getPlayerClasses() {
    return widget.player.classStats.map((ClassStats classStats) {
      return classStats.type;
    }).toList();
  }

  List<Player> _getOtherPlayersWithClass(String className) {
    List<Player> allPlayers = widget.log.players.values.toList();
    return allPlayers
        .where((player) =>
            widget.player.steamId != player.steamId &&
            _isClassPlayedByPlayer(player, className))
        .toList();
  }

  bool _isClassPlayedByPlayer(Player player, String className) {
    return player.classStats
            .where((classStats) => classStats.type == className)
            .length >
        0;
  }

  List<String> getPlayersNames(List<Player> players) {
    return players
        .map((player) => widget.log.getPlayerName(player.steamId))
        .toList();
  }

  Widget _getClassesDropdown() {
    return DropdownButton<String>(
        value: _selectedClass,
        style: TextStyle(color: Colors.black),
        items: _classes.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value, style: TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (value) {});
  }

  Widget _getPlayersDropdown() {
    return DropdownButton<Player>(
      value: _selectedPlayer,
      style: TextStyle(color: Colors.black),
      items: _otherPlayersWithSelectedClass.map((Player player) {
        return new DropdownMenuItem<Player>(
          value: player,
          child: new Text(widget.log.getPlayerName(player.steamId),
              style: TextStyle(fontSize: 16)),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }

  List<Widget> _getComparisonWidgets() {
    List<Widget> widgets = List();

    widgets.add(ComparisonCard(
        title: "Kills",
        playerValue: widget.player.kills.toDouble(),
        comparedPlayerValue: _selectedPlayer.kills.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
      title: "Deaths",
      playerValue: widget.player.deaths.toDouble(),
      comparedPlayerValue: _selectedPlayer.deaths.toDouble(),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      reversed: true,
    ));

    widgets.add(ComparisonCard(
        title: "Assists",
        playerValue: widget.player.assists.toDouble(),
        comparedPlayerValue: _selectedPlayer.assists.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "Damage",
        playerValue: widget.player.dmg.toDouble(),
        comparedPlayerValue: _selectedPlayer.dmg.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    return widgets;
  }
}

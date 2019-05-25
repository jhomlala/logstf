import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
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
    print("init state");
    _classes = _getPlayerClasses();
    _selectedClass = _classes[0];
    _otherPlayersWithSelectedClass = LogHelper.getOtherPlayersWithClass(
        widget.log, _selectedClass, widget.player.steamId);
    _selectedPlayer = _otherPlayersWithSelectedClass[0];
    _playerName = widget.log.getPlayerName(widget.player.steamId);
    _selectedPlayerName = widget.log.getPlayerName(_selectedPlayer.steamId);
    super.initState();
  }

  _onClassSelected(String className) {
    _otherPlayersWithSelectedClass = LogHelper.getOtherPlayersWithClass(
        widget.log, className, widget.player.steamId);
    if (_otherPlayersWithSelectedClass.isNotEmpty) {
      _selectedPlayer = _otherPlayersWithSelectedClass[0];
      _selectedPlayerName = widget.log.getPlayerName(_selectedPlayer.steamId);
    } else {
      _selectedPlayer = null;
      _selectedPlayerName = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.deepPurple),
        child: SingleChildScrollView(
            child:
            Container(child: Column(children: _getMainColumnWidgets()))));
  }

  List<Widget> _getMainColumnWidgets() {
    List<Widget> widgets = List();
    widgets.add(_getClassAndPlayerSelectionRow());
    if (_otherPlayersWithSelectedClass.isNotEmpty) {
      widgets.addAll(_getComparisonWidgets());
    } else {
      widgets.add(_getNoPlayersWithClassCard());
    }
    return widgets;
  }

  Widget _getNoPlayersWithClassCard() {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("There is no other player with same class to compare")
            ])));
  }

  Widget _getClassAndPlayerSelectionRow() {
    return Card(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 5),),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Class:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                  ),
                  _getClassesDropdown(),
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Compare to:", style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                  ),
                  _getPlayersDropdown()
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
              ],
            )));
  }

  List<String> _getPlayerClasses() {
    return widget.player.classStats.map((ClassStats classStats) {
      return classStats.type;
    }).toList();
  }

  Widget _getClassesDropdown() {
    return DropdownButton<String>(
        elevation: 2,
        isDense: true,
        iconSize: 20.0,
        value: _selectedClass,
        items: _classes.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(_formatClassName(value), style: TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (value) {
          _onClassSelected(value);
          setState(() {
            _selectedClass = value;
          });
        });
  }

  Widget _getPlayersDropdown() {
    return DropdownButton<Player>(
      elevation: 2,
      isDense: true,
      iconSize: 20.0,
      value: _selectedPlayer,
      items: _otherPlayersWithSelectedClass.map((Player player) {
        return new DropdownMenuItem<Player>(
          value: player,
          child: Text(widget.log.getPlayerName(player.steamId),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
              )),
        );
      }).toList(),
      onChanged: (value) {
        print("Selected.");
        setState(() {
          _selectedPlayer = value;
          print("selected: " + value.toString());
        });
      },
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

    widgets.add(ComparisonCard(
        title: "Damage per minute",
        playerValue: widget.player.dapm.toDouble(),
        comparedPlayerValue: _selectedPlayer.dapm.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
      title: "Kill & assists per death",
      playerValue: double.parse(widget.player.kapd),
      comparedPlayerValue: double.parse(_selectedPlayer.kapd),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      decimalPlaces: 2,
    ));

    widgets.add(ComparisonCard(
      title: "Kill per death",
      playerValue: double.parse(widget.player.kpd),
      comparedPlayerValue: double.parse(_selectedPlayer.kpd),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      decimalPlaces: 2,
    ));

    widgets.add(ComparisonCard(
        title: "Damage taken",
        playerValue: widget.player.dt.toDouble(),
        comparedPlayerValue: _selectedPlayer.dt.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "Captured points",
        playerValue: widget.player.cpc.toDouble(),
        comparedPlayerValue: _selectedPlayer.cpc.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "Inter captures",
        playerValue: widget.player.ic.toDouble(),
        comparedPlayerValue: _selectedPlayer.ic.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "Longest kill streak",
        playerValue: widget.player.lks.toDouble(),
        comparedPlayerValue: _selectedPlayer.lks.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "Medkits picked",
        playerValue: widget.player.medkits.toDouble(),
        comparedPlayerValue: _selectedPlayer.medkits.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "Restored HP from medkits",
        playerValue: widget.player.medkitsHp.toDouble(),
        comparedPlayerValue: _selectedPlayer.medkitsHp.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    if (_selectedClass == "sniper") {
      widgets.addAll(_getSniperComparisonCards());
    }

    if (_selectedClass == "medic") {
      widgets.addAll(_getMedicComparisonCards());
    }

    return widgets;
  }

  List<Widget> _getSniperComparisonCards() {
    List<Widget> widgets = List();
    widgets.add(ComparisonCard(
        title: "Headshots",
        playerValue: widget.player.headshots.toDouble(),
        comparedPlayerValue: _selectedPlayer.headshots.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "Headshots hit",
        playerValue: widget.player.headshotsHit.toDouble(),
        comparedPlayerValue: _selectedPlayer.headshotsHit.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));
    return widgets;
  }

  List<Widget> _getMedicComparisonCards() {
    List<Widget> widgets = List();
    widgets.add(ComparisonCard(
        title: "Ubers",
        playerValue: widget.player.ubers.toDouble(),
        comparedPlayerValue: _selectedPlayer.ubers.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
      title: "Drops",
      playerValue: widget.player.drops.toDouble(),
      comparedPlayerValue: _selectedPlayer.drops.toDouble(),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      reversed: true,
    ));

    return widgets;
  }

  String _formatClassName(String rawClassName) {
    if (rawClassName == "heavyweapons") {
      return "Heavy";
    } else {
      return rawClassName.substring(0, 1).toUpperCase() +
          rawClassName.substring(1, rawClassName.length);
    }
  }
  
}

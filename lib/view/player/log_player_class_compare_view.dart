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
}

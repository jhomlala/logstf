import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/ui/player/widget/comparison_card.dart';

class LogPlayerClassCompareFragment extends StatefulWidget {
  final Log _log;
  final Player _player;

  const LogPlayerClassCompareFragment(this._log, this._player);

  @override
  _LogPlayerClassCompareFragmentState createState() =>
      _LogPlayerClassCompareFragmentState();
}

class _LogPlayerClassCompareFragmentState extends State<LogPlayerClassCompareFragment> {
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
        widget._log, _selectedClass, widget._player.steamId);
    if (_otherPlayersWithSelectedClass.isNotEmpty) {
      _selectedPlayer = _otherPlayersWithSelectedClass[0];
      _playerName = widget._log.getPlayerName(widget._player.steamId);
      _selectedPlayerName = widget._log.getPlayerName(_selectedPlayer.steamId);
    }
    super.initState();
  }

  _onClassSelected(String className) {
    _otherPlayersWithSelectedClass = LogHelper.getOtherPlayersWithClass(
        widget._log, className, widget._player.steamId);
    if (_otherPlayersWithSelectedClass.isNotEmpty) {
      _selectedPlayer = _otherPlayersWithSelectedClass[0];
      _selectedPlayerName = widget._log.getPlayerName(_selectedPlayer.steamId);
    } else {
      _selectedPlayer = null;
      _selectedPlayerName = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
            child:
                Container(child: Column(children: _getMainColumnWidgets()))));
  }

  List<Widget> _getMainColumnWidgets() {
    ApplicationLocalization applicationLocalization =
        ApplicationLocalization.of(context);
    List<Widget> widgets = List();
    widgets.add(_getClassAndPlayerSelectionRow(applicationLocalization));
    if (_otherPlayersWithSelectedClass.isNotEmpty) {
      widgets.addAll(_getComparisonWidgets(applicationLocalization));
    } else {
      widgets.add(_getNoPlayersWithClassCard(applicationLocalization));
    }
    return widgets;
  }

  Widget _getNoPlayersWithClassCard(
      ApplicationLocalization applicationLocalization) {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(applicationLocalization.getText("log_compare_to_no_players"))
            ])));
  }

  Widget _getClassAndPlayerSelectionRow(
      ApplicationLocalization applicationLocalization) {
    return Card(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "${applicationLocalization.getText("log_class")}:",
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
                  Text("${applicationLocalization.getText("log_compare_to")}:",
                      style: TextStyle(fontSize: 16)),
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
    return widget._player.classStats.map((ClassStats classStats) {
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
            child: new Text(_formatClassName(value),
                style: TextStyle(fontSize: 16)),
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
    if (_otherPlayersWithSelectedClass == null ||
        _otherPlayersWithSelectedClass.isEmpty) {
      return Text(
        "None",
        style: TextStyle(fontSize: 16),
      );
    }

    return DropdownButton<Player>(
      elevation: 2,
      isDense: true,
      iconSize: 20.0,
      value: _selectedPlayer,
      items: _otherPlayersWithSelectedClass.map((Player player) {
        return new DropdownMenuItem<Player>(
          value: player,
          child: Text(widget._log.getPlayerName(player.steamId),
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
        });
      },
    );
  }

  List<Widget> _getComparisonWidgets(
      ApplicationLocalization applicationLocalization) {
    List<Widget> widgets = List();

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_kills")}",
        plural: "${applicationLocalization.getText("log_compare_kills")}",
        playerValue: widget._player.kills.toDouble(),
        comparedPlayerValue: _selectedPlayer.kills.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
      title: "${applicationLocalization.getText("log_deaths")}",
      plural: "${applicationLocalization.getText("log_class_medic_deaths_deaths")}",
      playerValue: widget._player.deaths.toDouble(),
      comparedPlayerValue: _selectedPlayer.deaths.toDouble(),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      reversed: true,
    ));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_assists")}",
        plural: "${applicationLocalization.getText("log_compare_assists")}",
        playerValue: widget._player.assists.toDouble(),
        comparedPlayerValue: _selectedPlayer.assists.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_damage")}",
        plural: "${applicationLocalization.getText("log_compare_damage")}",
        playerValue: widget._player.dmg.toDouble(),
        comparedPlayerValue: _selectedPlayer.dmg.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_damage_per_minute")}",
        plural: "${applicationLocalization.getText("log_compare_dpm")}",
        playerValue: widget._player.dapm.toDouble(),
        comparedPlayerValue: _selectedPlayer.dapm.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
      title: "${applicationLocalization.getText("log_kapd")}",
      plural: "${applicationLocalization.getText("log_compare_kapd")}",
      playerValue: double.parse(widget._player.kapd),
      comparedPlayerValue: double.parse(_selectedPlayer.kapd),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      decimalPlaces: 2,
    ));

    widgets.add(ComparisonCard(
      title: "${applicationLocalization.getText("log_kpd")}",
      plural: "${applicationLocalization.getText("log_compare_kpd")}",
      playerValue: double.parse(widget._player.kpd),
      comparedPlayerValue: double.parse(_selectedPlayer.kpd),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      decimalPlaces: 2,
    ));

    widgets.add(ComparisonCard(
      title: "${applicationLocalization.getText("log_damage_taken")}",
      plural: "${applicationLocalization.getText("log_compare_damage_taken")}",
      playerValue: widget._player.dt.toDouble(),
      comparedPlayerValue: _selectedPlayer.dt.toDouble(),
      playerName: _playerName,
      comparedPlayerName: _selectedPlayerName,
      reversed: true,
    ));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_compare_captured_points")}",
        plural: "${applicationLocalization.getText("log_compare_captured_points_captured_points")}",
        playerValue: widget._player.cpc.toDouble(),
        comparedPlayerValue: _selectedPlayer.cpc.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_compare_captured_intel")}",
        plural: "${applicationLocalization.getText("log_compare_captured_intel_captured_intel")}",
        playerValue: widget._player.ic.toDouble(),
        comparedPlayerValue: _selectedPlayer.ic.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_compare_longest_kill_streak")}",
        plural: "${applicationLocalization.getText("log_compare_longest_kill_streak_longest_kill_streak")}",
        playerValue: widget._player.lks.toDouble(),
        comparedPlayerValue: _selectedPlayer.lks.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_compare_medkits_picked_medkits_picked")}",
        plural: "${applicationLocalization.getText("log_compare_medkits_picked_medkits_picked_medkits_picked")}",
        playerValue: widget._player.medkits.toDouble(),
        comparedPlayerValue: _selectedPlayer.medkits.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_compare_restored_hp_from_medkits")}",
        plural: "${applicationLocalization.getText("log_compare_restored_hp_from_medkits_restored_hp_from_medkits")}",
        playerValue: widget._player.medkitsHp.toDouble(),
        comparedPlayerValue: _selectedPlayer.medkitsHp.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    if (_selectedClass == "sniper") {
      widgets.addAll(_getSniperComparisonCards(applicationLocalization));
    }

    if (_selectedClass == "medic") {
      widgets.addAll(_getMedicComparisonCards(applicationLocalization));
    }

    return widgets;
  }

  List<Widget> _getSniperComparisonCards(ApplicationLocalization applicationLocalization) {
    List<Widget> widgets = List();
    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_headshots")}",
        plural: "${applicationLocalization.getText("log_compare_headshots")}",
        playerValue: widget._player.headshots.toDouble(),
        comparedPlayerValue: _selectedPlayer.headshots.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText("log_class_headshots_hits")}",
        plural: "${applicationLocalization.getText("log_compare_headshots_hits")}",
        playerValue: widget._player.headshotsHit.toDouble(),
        comparedPlayerValue: _selectedPlayer.headshotsHit.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));
    return widgets;
  }

  List<Widget> _getMedicComparisonCards(ApplicationLocalization applicationLocalization) {
    List<Widget> widgets = List();
    widgets.add(ComparisonCard(
        title: "${applicationLocalization.getText(
            "log_compare_ubers")}",
        plural: "${applicationLocalization.getText("log_compare_ubers_ubers")}",
        playerValue: widget._player.ubers.toDouble(),
        comparedPlayerValue: _selectedPlayer.ubers.toDouble(),
        playerName: _playerName,
        comparedPlayerName: _selectedPlayerName));

    widgets.add(ComparisonCard(
      title: "${applicationLocalization.getText("log_drops")}",
      plural: "${applicationLocalization.getText("log_compare_drops")}",
      playerValue: widget._player.drops.toDouble(),
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

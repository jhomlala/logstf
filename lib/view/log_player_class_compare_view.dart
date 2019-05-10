import 'package:flutter/material.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

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
    _otherPlayersWithSelectedClass = _getOtherPlayersWithClass(_selectedClass);
    _selectedPlayer = _otherPlayersWithSelectedClass[0];
    _playerName = widget.log.getPlayerName(widget.player.steamId);
    _selectedPlayerName = widget.log.getPlayerName(_selectedPlayer.steamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(child: Column(children: _getMainColumnWidgets())));
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
    widgets.add(_getComparisonCard("Kills", widget.player.kills.toDouble(),
        _selectedPlayer.kills.toDouble()));
    widgets.add(_getComparisonCard("Deaths", widget.player.deaths.toDouble(),
        _selectedPlayer.deaths.toDouble()));
    widgets.add(_getComparisonCard("Assists", widget.player.assists.toDouble(),
        _selectedPlayer.assists.toDouble()));
    widgets.add(_getComparisonCard("Damage", widget.player.dmg.toDouble(),
        _selectedPlayer.dmg.toDouble()));

    return widgets;
  }

  Card _getComparisonCard(
      String title, double playerValue, double comparedPlayerValue) {
    String winnerText = "";
    String winnerDescription = "";
    String winnerPlayer = "";
    double percentage = 0.0;
    String loserPlayer = "";

    Color playerValueColor = Colors.black;
    Color comparedPlayerValueColor = Colors.black;



    if (playerValue > comparedPlayerValue) {
      winnerText = "$_playerName wins!";
      percentage = (comparedPlayerValue / playerValue) * 100;
      winnerPlayer = _playerName;
      loserPlayer = _selectedPlayerName;

      playerValueColor = Colors.green;
      comparedPlayerValueColor = Colors.red;
    } else if (playerValue < comparedPlayerValue) {
      winnerText = "$_selectedPlayerName wins!";
      percentage = (playerValue / comparedPlayerValue) * 100;
      winnerPlayer = _selectedPlayerName;
      loserPlayer = _playerName;
      //winnerDescription =
       //   "$_selectedPlayerName had ${percentage.toStringAsFixed(0)}% more ${title.toLowerCase()} than $_playerName.";
      playerValueColor = Colors.red;
      comparedPlayerValueColor = Colors.green;
    } else {
      winnerText = "It's a tie!";

    }

    return Card(
      child: Column(children: [
        Text(
          title,
          style: TextStyle(fontSize: 30),
        ),


        Text(
          winnerText,
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        RichText(
          text: new TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: new TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              new TextSpan(text: "$winnerPlayer", style: new TextStyle(fontWeight: FontWeight.bold)),
              new TextSpan(text: " had"),
              new TextSpan(text: " ${percentage.toStringAsFixed(0)}%", style: new TextStyle(fontWeight: FontWeight.bold)),
              new TextSpan(text: " more ${title.toLowerCase()} than "),
              new TextSpan(text: "$loserPlayer.", style: new TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(children: [
              Container(
                constraints: BoxConstraints(maxWidth: 100),
                child: Text(_playerName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(playerValue.toStringAsFixed(0),
                  style: TextStyle(fontSize: 20, color: playerValueColor))
            ]),
            Column(children: [
              Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: Text(_selectedPlayerName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 24))),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(comparedPlayerValue.toStringAsFixed(0),
                  style:
                      TextStyle(fontSize: 20, color: comparedPlayerValueColor))
            ]),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        )
      ]),
    );
  }
}

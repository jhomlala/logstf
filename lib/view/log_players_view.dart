import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_bloc.dart';
import 'package:logstf/bloc/log_bloc_provider.dart';
import 'package:logstf/helper/stats_manager.dart';

import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/view/player/log_player_detailed_view.dart';
import 'package:logstf/widget/table_header_widget.dart';

class LogPlayersView extends StatefulWidget {

  @override
  _LogPlayersViewState createState() => _LogPlayersViewState();
}

class _LogPlayersViewState extends State<LogPlayersView> {
  LogBloc _bloc;
  Log _log;
  Map<String, Player> _players;
  Map<String, String> _playerNames;
  String _filterName = "Kills";
  HashMap<String, AveragePlayerStats> _averagePlayerStatsMap;


  void init(BuildContext context) {
    _bloc = LogBlocProvider.of(context);
    _log = _bloc.logSubject.value;
    _players = _log.players;
    _playerNames = _log.names;
    var length =_log.length;
    _averagePlayerStatsMap = HashMap();
    _averagePlayerStatsMap["ALL"] =
        StatsManager.getAveragePlayerStatsForAllPlayers(
            _players.values.toList(), length);
    _averagePlayerStatsMap["Red"] = StatsManager.getAveragePlayerStatsForTeam(
        _players.values.toList(), length, "Red");
    _averagePlayerStatsMap["Blue"] = StatsManager.getAveragePlayerStatsForTeam(
        _players.values.toList(),length, "Blue");
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      _getFilterDropdownWidget(),
      Table(
        border: TableBorder(
            left: BorderSide(
              color: Colors.black,
            ),
            right: BorderSide(
              color: Colors.black,
            ),
            top: BorderSide(
              color: Colors.black,
            )),
        children: _getTableRows(),
      )
    ]));
  }

  Widget _getFilterDropdownWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Metric: "),
      Padding(
        padding: EdgeInsets.only(left: 5),
      ),
      DropdownButton<String>(
        value: _filterName,
        style: TextStyle(color: Colors.black),
        items: <String>[
          "Kills",
          "Assists",
          "Deaths",
          "DA",
          "DA/M",
          "KA/D",
          "K/D",
          "DT",
          "DT/M",
          "HP",
          "HS",
          "AS",
          "CAP"
        ].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _filterName = value;
          });
        },
      )
    ]);
  }

  List<TableRow> _getTableRows() {
    List<TableRow> tableRowsList = List<TableRow>();
    var playersList = _players.values.toList();
    var playersListOrdered = orderPlayersByField(playersList);

    tableRowsList.add(getHeaderTableRow());
    for (int index = 0; index < playersListOrdered.length; index++) {
      var player = playersListOrdered[index];
      var name = _playerNames[player.steamId];

      var tableRow = TableRow(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black))),
          children: [
            _getTeamWidget(player),
            _getPlayerNameWidget(player, name),
            _getPlayerClassesWidget(player),
            _getCurrentStatWidget(player),
          ]);
      tableRowsList.add(tableRow);
    }
    return tableRowsList;
  }

  void onPlayerClicked(Player player) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LogPlayerDetailedView(
                _log, player, _averagePlayerStatsMap)));
  }

  List<Player> orderPlayersByField(List<Player> players) {
    List<Player> playersCopy = List();
    playersCopy.addAll(players);
    switch (_filterName) {
      case "Kills":
        playersCopy
            .sort((player1, player2) => player2.kills.compareTo(player1.kills));
        break;
      case "Deaths":
        playersCopy.sort(
            (player1, player2) => player2.deaths.compareTo(player1.deaths));
        break;
      case "Assists":
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
            .sort((player1, player2) => player2.as.compareTo(player1.as));
        break;
    }
    return playersCopy;
  }

  double _calculateDamageTakenPerMinute(int damgeTaken) {
    var length = _log.length / 60;
    return damgeTaken / length;
  }

  TableRow getHeaderTableRow() {
    return TableRow(children: [
      TableHeaderWidget("TEAM"),
      TableHeaderWidget("PLAYER"),
      TableHeaderWidget("CLASSES"),
      TableHeaderWidget(_filterName),
    ]);
  }




  Widget _getPlayerNameWidget(Player player, String name) {
    return InkWell(
      onTap: () {
        onPlayerClicked(player);
      },
      child: Container(
          height: 30,
          padding: EdgeInsets.only(left: 5),
          child: Center(
              child: Text(
            name,
            overflow: TextOverflow.ellipsis,
          ))),
    );
  }

  Widget _getPlayerClassesWidget(Player player) {
    List<Widget> classIcons = List();
    var classStatsList = player.classStats;
    classStatsList.forEach((classStats) {
      var asset = "";

      switch (classStats.type) {
        case "scout":
          asset = "assets/scout.png";
          break;
        case "soldier":
          asset = "assets/soldier.png";
          break;
        case "pyro":
          asset = "assets/pyro.png";
          break;
        case "heavyweapons":
          asset = "assets/heavy.png";
          break;
        case "engineer":
          asset = "assets/engineer.png";
          break;
        case "demoman":
          asset = "assets/demoman.png";
          break;
        case "medic":
          asset = "assets/medic.png";
          break;
        case "sniper":
          asset = "assets/sniper.png";
          break;
        case "spy":
          asset = "assets/spy.png";
          break;
      }

      if (asset.length > 0) {
        classIcons.add(
          Image.asset(
            asset,
            width: 20,
            height: 20,
          ),
        );
      }
    });
    return Center(
        child: Container(
            height: 30,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: classIcons)));
  }

  String _getPlayerName(String steamId) {
    if (_playerNames.containsKey(steamId)) {
      return _playerNames[steamId];
    } else {
      return "";
    }
  }

  Widget _getTeamWidget(Player player) {
    var teamColor = Colors.red;
    var teamName = "RED";
    if (player.team == "Blue") {
      teamColor = Colors.blue;
      teamName = "BLU";
    }

    return InkWell(
        onTap: () {
          onPlayerClicked(player);
        },
        child: Container(
            height: 30,
            width: 50,
            decoration: BoxDecoration(
                color: teamColor,
                border: Border(bottom: BorderSide(color: Colors.black))),
            child: Center(
              child: Text(teamName, style: TextStyle(color: Colors.white)),
            )));
  }

  _getCurrentStatWidget(Player player) {
    String value = "";
    switch (_filterName) {
      case "Kills":
        value = "${player.kills}";
        break;
      case "Deaths":
        value = "${player.deaths}";
        break;
      case "Assists":
        value = "${player.assists}";
        break;
      case "DA":
        value = "${player.dmg}";
        break;
      case "DA/M":
        value = "${player.dapm}";
        break;
      case "KA/D":
        value = "${player.kapd}";
        break;
      case "K/D":
        value = "${player.kpd}";
        break;
      case "DT":
        value = "${player.dt}";
        break;
      case "DT/M":
        value = "${_calculateDamageTakenPerMinute(player.dt)}";
        break;
      case "HP":
        value = "${player.heal}";
        break;
      case "HS":
        value = "${player.headshots}";
        break;
      case "AS":
        value = "${player.as}";
        break;
      case "CAP":
        value = "${player.as}";
        break;
    }

    return Container(
      height: 30,
      width: 100,
      padding: EdgeInsets.only(left: 5),
      child: Center(child: Text(value)),
    );
  }
}

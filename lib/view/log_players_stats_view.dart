import 'package:flutter/material.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';

class LogPlayersStatsView extends StatefulWidget {
  LogPlayersStatsView(this.log);

  final Log log;

  @override
  _LogPlayersStatsViewState createState() => _LogPlayersStatsViewState();
}

class _LogPlayersStatsViewState extends State<LogPlayersStatsView> {
  Map<String, Player> _players;
  Map<String, String> _playerNames;
  String _filterName = "Kills";

  @override
  void initState() {
    super.initState();
    _players = widget.log.players;
    _playerNames = widget.log.names;
  }

  @override
  Widget build(BuildContext context) {
    var _playersSteamIds = _players.keys.toList();
    var _playersList = _players.values.toList();

    /*return ListView.builder(
        itemCount: _players.length,
        itemBuilder: (buildContext, position) {
          var player = _playersList[position];
          return  Row(children: [
            _getTeamWidget(player),
            Container(width: 100, padding:EdgeInsets.only(left:5),child: Text(_getPlayerName(_playersSteamIds[position])))
          ]);
        });*/

    return Column(children: <Widget>[
       DropdownButton<String>(value: _filterName,
        items: <String>['Kills', 'Assists', 'Deaths', 'Suicides', 'KA/D', 'K/D'].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {
         setState((){
           _filterName = value;
         });
        },
      ),
      Table(
      children: _getTableRows(),
    )]);
  }

  List<TableRow> _getTableRows() {
    List<TableRow> tableRowsList = List<TableRow>();
    var playersList = _players.values.toList();
    var playersListOrdered = orderPlayersByField(playersList);

    tableRowsList.add(getHeaderTableRow());
    for (int index = 0; index < playersListOrdered.length; index++) {
      var player = playersListOrdered[index];
      var name = _playerNames[player.steamId];

      var tableRow = TableRow(decoration: BoxDecoration(border:Border(bottom: BorderSide(color: Colors.black))),children: [
        _getTeamWidget(player),
       _getPlayerNameWidget(name),
        _getPlayerClassesWidget(player),
       _getCurrentStatWidget(player)
      ]);
      tableRowsList.add(tableRow);
    }
    return tableRowsList;
  }



  List<Player> orderPlayersByField(List<Player> players){
    List<Player> playersCopy = List();
    playersCopy.addAll(players);
    switch(_filterName){
      case "Kills":
        playersCopy.sort((player1,player2) => player2.kills.compareTo(player1.kills));
        break;
      case "Deaths":
        playersCopy.sort((player1,player2) => player2.deaths.compareTo(player1.deaths));
        break;
      case "Assists":
        playersCopy.sort((player1, player2) =>
            player2.assists.compareTo(player1.assists));
        break;
      case "Suicides":
        playersCopy.sort((player1,player2) => player2.suicides.compareTo(player1.suicides));
        break;
      case "KA/D":
        playersCopy.sort((player1,player2) => double.parse(player2.kapd).compareTo(double.parse(player1.kapd)));
        break;
      case "K/D":
        playersCopy.sort((player1,player2) => double.parse(player2.kpd).compareTo(double.parse(player1.kpd)));
        break;

    }

    return playersCopy;
  }

  TableRow getHeaderTableRow(){
    return TableRow(children: [_getHeaderWidget("TEAM"),_getHeaderWidget("PLAYER"), _getHeaderWidget("CLASSES"), _getHeaderWidget(_filterName)]);
  }


  Widget _getHeaderWidget(String headerName){
    return Container(height: 30,decoration: BoxDecoration(color: AppUtils.darkBlueColor,), child: Center(child:Text(headerName, style: TextStyle(color:Colors.white),)),);
  }

  Widget _getPlayerNameWidget(String name){
    return Container(
      height:30,  padding: EdgeInsets.only(left: 5), child: Center(child: Text(name, overflow: TextOverflow.ellipsis,)),);
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
        case "heavy":
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
    return Center(child: Container(height:30,child:Row(mainAxisAlignment:MainAxisAlignment.center,children: classIcons)));
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

    return Container(
      height:30,

        decoration: BoxDecoration(color: teamColor, border: Border(bottom: BorderSide(color: Colors.black))),
        child: Center(
          child: Text(teamName, style: TextStyle(color: Colors.white)),
        ));
  }

  _getCurrentStatWidget(Player player) {
    String value = "";
    switch (_filterName){
      case "Kills":
        value = "${player.kills}";
        break;
      case "Deaths":
        value = "${player.deaths}";
        break;
      case "Assists":
        value = "${player.assists}";
        break;
      case "Suicides":
        value = "${player.suicides}";
        break;
      case "KA/D":
        value = "${player.kapd}";
        break;
      case "K/D":
        value = "${player.kpd}";
        break;
    }

    return Container(
      height:30,
      width: 100, padding: EdgeInsets.only(left: 5), child: Center(child: Text(value)),);
  }



}

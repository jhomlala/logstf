import 'package:flutter/material.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';


class AwardCard extends StatelessWidget {
  final String awardName;
  final Log log;
  final List<Player> players;
  final String description;

  const AwardCard(
      {Key key, this.awardName, this.players, this.description, this.log})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(awardName, style: TextStyle(fontSize: 20)),
              ]),
              Text(description),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Table(
                defaultColumnWidth: IntrinsicColumnWidth(),
                children: [
                  _getPlayerRow(players[0], 1),
                  _getPlayerRow(players[1], 2),
                  _getPlayerRow(players[2], 3),
                ],
              )
            ],
          )),
    );
  }

  TableRow _getPlayerRow(Player player, int place) {
    var placeImage = "assets/first_place.png";
    var fontSize = 20.0;
    if (place == 2) {
      placeImage = "assets/second_place.png";
      fontSize = 20.0;
    } else if (place == 3) {
      placeImage = "assets/third_place.png";
      fontSize = 20.0;
    }
    var color = Colors.red;
    if (player.team == "Blue"){
      color = Colors.blue;
    }


    return TableRow(children: [
      Image.asset(placeImage, width: 20, height: 20),
      Container(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            log.getPlayerName(player.steamId),
            style: TextStyle(fontSize: fontSize, color: color),
          )),

    ]);
  }
}

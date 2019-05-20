import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

import 'class_icon.dart';

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
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(awardName, style: TextStyle(fontSize: 20)),
              ]),
              Text(description),
              Table(defaultColumnWidth: IntrinsicColumnWidth(),children: [ _getPlayerRow(players[0],1), _getPlayerRow(players[1],2), _getPlayerRow(players[2],3),],)


            ],
          )),
    );
  }

  TableRow _getPlayerRow(Player player, int place){
    var placeImage = "assets/first_place.png";
    var fontSize = 20.0;
    if (place == 2){
      placeImage = "assets/second_place.png";
      fontSize = 20.0;
    } else if (place == 3){
      placeImage = "assets/third_place.png";
      fontSize = 20.0;
    }


    return TableRow(children: [
      Image.asset(placeImage,width: 30, height: 30,),
      Text(
        log.getPlayerName(player.steamId),
        style: TextStyle(fontSize: fontSize),
      ), ClassIcon(
        playerClass: LogHelper.getPlayerClasses(player)[0],
      ),
    ]);
  }
}

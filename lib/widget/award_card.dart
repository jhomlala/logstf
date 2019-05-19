import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

import 'class_icon.dart';

class AwardCard extends StatefulWidget {

  final String awardName;
  final Log log;
  final Player player;
  final String description;

  const AwardCard(
      {Key key, this.awardName, this.player, this.description, this.log})
      : super(key: key);

  @override
  _AwardCardState createState() => _AwardCardState();
}

class _AwardCardState extends State<AwardCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/award.png", height: 20),
                Text(widget.awardName, style: TextStyle(fontSize: 20)),
                Image.asset(
                  "assets/award.png",
                  height: 20,
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ClassIcon(
                  playerClass: LogHelper.getPlayerClasses(widget.player)[0],
                ),
                Text(
                  widget.log.getPlayerName(widget.player.steamId),
                  style: TextStyle(fontSize: 30),
                )
              ]),
              Text(widget.description)
            ],
          )),
    );
  }
}

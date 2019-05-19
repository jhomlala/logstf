import 'package:flutter/material.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/award_card.dart';
import 'package:logstf/widget/class_icon.dart';

class LogAwardsView extends StatefulWidget {
  final Log log;

  const LogAwardsView({Key key, this.log}) : super(key: key);

  @override
  _LogAwardsViewState createState() => _LogAwardsViewState();
}

class _LogAwardsViewState extends State<LogAwardsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.deepPurple,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[AwardCard(awardName: "Most valuable kills", player: getMVPPlayer(), log: widget.log, description: "Had most kills!",)],
        )));
  }

  Player getMVPPlayer(){
    List<Player> players = widget.log.players.values.toList();
    players.sort((player1,player2) => player2.kills.compareTo(player1.kills));
    return players[0];

  }
}

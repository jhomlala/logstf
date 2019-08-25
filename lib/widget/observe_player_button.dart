import 'package:flutter/material.dart';
import 'package:logstf/bloc/players_observed_bloc.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';

import 'logs_button.dart';

class ObservePlayerButton extends StatefulWidget {
  final String steamId64;
  final String playerName;

  const ObservePlayerButton({Key key, this.steamId64, this.playerName}) : super(key: key);

  @override
  _ObservePlayerButtonState createState() => _ObservePlayerButtonState();
}

class _ObservePlayerButtonState extends State<ObservePlayerButton> {



  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: playersObservedLocalProvider.getPlayerObservedWithSteamId64(widget.steamId64),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting){
            return _getPageButton("", (){});
          } else if (snapshot.connectionState == ConnectionState.done){
            PlayerObserved snapshotData = snapshot.data as PlayerObserved;
            if (snapshotData != null){
              return _getPageButton(" Remove from observed",
                  _removeObservedPlayer,
                  backgroundColor: Theme.of(context).primaryColor);
            } else {
              return _getPageButton("Observe",
                  _observePlayer,
                  backgroundColor: Theme.of(context).primaryColor);
            }
          } else {
            return _getPageButton("", (){});
          }
        });
  }

  Widget _getPageButton(String text, Function action,
      {Color backgroundColor = Colors.deepOrange}) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: LogsButton(
              text: text,
              onPressed: action,
              backgroundColor: backgroundColor,
            )));
  }

  void _observePlayer() async {
    PlayerObserved playerObserved = await playersObservedBloc.getPlayerObserved(
        widget.steamId64);
    if (playerObserved == null) {
      playerObserved = PlayerObserved(id: DateTime
          .now()
          .millisecondsSinceEpoch,
          name: widget.playerName,
          steamid64: widget.steamId64);
      await playersObservedBloc.addPlayerObserved(playerObserved);
      setState(() {

      });
    }
  }

  void _removeObservedPlayer() async{
    PlayerObserved playerObserved = await playersObservedBloc.getPlayerObserved(
        widget.steamId64);
    playersObservedBloc.deletePlayerObserved(playerObserved.id);
    setState(() {

    });

  }
}

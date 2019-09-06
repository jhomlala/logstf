import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/player_search_result.dart';

class PlayerSearchRowWidget extends StatelessWidget {
  final PlayerSearchResult playerSearchResult;

  const PlayerSearchRowWidget({Key key, this.playerSearchResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Card(child:
      Container(margin:EdgeInsets.all(5),child:Row(children: [
       _getImage(playerSearchResult.avatarUrl),
        Padding(padding: EdgeInsets.only(left:5)),
        Container(width: MediaQuery.of(context).size.width*0.8,child: Text(playerSearchResult.playerNames.join(", "), maxLines: 5,))
      ])),
    ), onTap: (){
      _onPlayerClicked(context);
    });
  }

  _onPlayerClicked(BuildContext context) {
    print("On player fclicked!!!");
    logsSearchBloc.clearFilters();
    logsSearchBloc.searchLogs(player: playerSearchResult.steamId);
   Navigator.of(context).pop();
  }

  Widget _getImage(String url){
    if (url != null){
      return Image.network(playerSearchResult.avatarUrl);
    } else {
      return Image.asset("assets/tf2logo.png", width: 32,height: 32);
    }
  }
}

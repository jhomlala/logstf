import 'package:flutter/material.dart';
import 'package:logstf/bloc/player_search_bloc.dart';
import 'package:logstf/model/player_search_result.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/player_search_row_widget.dart';
import 'package:logstf/widget/progress_bar.dart';

class PlayerSearchResultsView extends StatefulWidget {
  final String playerName;

  const PlayerSearchResultsView({Key key, this.playerName}) : super(key: key);

  @override
  _PlayerSearchResultsViewState createState() =>
      _PlayerSearchResultsViewState();
}

class _PlayerSearchResultsViewState extends State<PlayerSearchResultsView> {
  @override
  void initState() {
    playerSearchBloc.searchPlayers(widget.playerName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(elevation: 0.0, title: Text("Search: ${widget.playerName}")),
        body: Container(
            color: Theme.of(context).primaryColor,
            child: StreamBuilder<List<PlayerSearchResult>>(
              stream: playerSearchBloc.playersSearchSubject,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none ||
                    playerSearchBloc.loading) {
                  return ProgressBar();
                } else {
                  var items = playerSearchBloc.playersSearchSubject.value;
                  if (items != null && items.length > 0) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, position) {
                        return PlayerSearchRowWidget(
                            playerSearchResult: items[position]);
                      },
                    );
                  } else {
                    return EmptyCard(description: "No players found");
                  }
                }
              },
            )));
  }
}

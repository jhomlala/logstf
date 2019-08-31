import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_player_observed_bloc.dart';
import 'package:logstf/bloc/players_observed_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/util/error_handler.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';

class LogsWatchListView extends StatefulWidget {
  @override
  _LogsWatchListViewState createState() => _LogsWatchListViewState();
}

class _LogsWatchListViewState extends State<LogsWatchListView>
    with AutomaticKeepAliveClientMixin<LogsWatchListView> {
  PlayerObserved _selectedPlayer;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
    playersObservedBloc.getPlayersObserved();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder(
            stream: playersObservedBloc.playersObservedSubject.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              } else {
                List<PlayerObserved> observedPlayers = snapshot.data;
                print("Observed players: " + observedPlayers.toString());
                if (_selectedPlayer == null && observedPlayers.length > 0) {
                  _selectedPlayer = observedPlayers[0];
                  logsPlayerObservedBloc.searchLogs(_selectedPlayer.steamid64);
                }
                return Column(children: [
                  _getPlayersChooserCard(snapshot.data),
                  StreamBuilder<List<LogShort>>(
                      stream: logsPlayerObservedBloc.logsSearchSubject,
                      initialData:
                          logsPlayerObservedBloc.logsSearchSubject.value,
                      builder: (context, snapshot) {
                        if (!logsPlayerObservedBloc.loading) {
                          if (snapshot.hasError) {
                            return EmptyCard(
                              description:
                                  ErrorHandler.handleError(snapshot.error),
                            );
                          }

                          var data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return EmptyCard(
                              description: "There's no data. ",
                            );
                          } else {
                            return Expanded(
                                child: NotificationListener<ScrollNotification>(
                                    onNotification: _handleScrollNotification,
                                    child: ListView.builder(
                                        controller: _controller,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return LogShortCard(
                                              logSearch: data[index]);
                                        })));
                          }
                        } else {
                          return ProgressBar();
                        }
                      })
                ]);
              }
            }));
  }

  @override
  bool get wantKeepAlive => true;

  Widget _getPlayersDropdown(List<PlayerObserved> players) {
    if (players
            .where((PlayerObserved player) => player == _selectedPlayer)
            .length ==
        0) {
      _selectedPlayer = players[0];
    }

    return DropdownButton<PlayerObserved>(
        elevation: 2,
        isDense: true,
        iconSize: 20.0,
        value: _selectedPlayer,
        items: players.map((PlayerObserved value) {
          return new DropdownMenuItem<PlayerObserved>(
            value: value,
            child: new Text(value.name, style: TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (value) {
          logsPlayerObservedBloc.clearLogs();
          logsPlayerObservedBloc.searchLogs(value.steamid64);
          setState(() {
            _selectedPlayer = value;
          });
        });
  }

  Widget _getPlayersChooserCard(List<PlayerObserved> playersObserved) {
    List<Widget> widgets = List();
    if (playersObserved.length > 0) {
      widgets.add(Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
        child: Text("Player:", style: TextStyle(fontSize: 16)),
      ));
      widgets.add(Row(children: [
        _getPlayersDropdown(playersObserved),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.grey,),
          onPressed: () {
            playersObservedBloc.deletePlayerObserved(_selectedPlayer.id);
            logsPlayerObservedBloc.clearLogs();
            _selectedPlayer = null;
          },
        )
      ]));
    } else {
      widgets.add(Padding(
          padding: EdgeInsets.all(10),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                "No players observed. Please add player by clicking Observe player in player details.",
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ))));
    }

    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_controller.position.extentAfter == 0 &&
          !logsPlayerObservedBloc.loading) {
        logsPlayerObservedBloc.searchLogs(_selectedPlayer.steamid64);
      }
    }
    return false;
  }
}

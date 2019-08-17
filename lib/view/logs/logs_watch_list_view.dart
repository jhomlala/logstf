import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_player_observed_bloc.dart';
import 'package:logstf/bloc/logs_saved_bloc.dart';
import 'package:logstf/bloc/players_observed_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player_observed.dart';
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

  @override
  void initState() {
    super.initState();
    playersObservedBloc.getPlayersObserved();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: Colors.deepPurple,
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
                          var data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return EmptyCard(
                              description: "There's no saved data. ",
                            );
                          } else {
                            return Expanded(
                                child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return LogShortCard(
                                          logSearch: data[index]);
                                    }));
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
    if (players.where((PlayerObserved player) => player == _selectedPlayer ).length == 0){
      _selectedPlayer = players[0];
    }

    print("Dropdown button with players: " +
        players.toString() +
        " selected player: " +
        _selectedPlayer.toString());

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
          logsPlayerObservedBloc.searchLogs(value.steamid64);
          setState(() {
            _selectedPlayer = value;
          });
        });
  }

  Widget _getPlayersChooserCard(List<PlayerObserved> playersObserved) {
    Widget widget;
    if (playersObserved.length > 0) {
      widget = _getPlayersDropdown(playersObserved);
    } else {
      widget = Text("No players");
    }

    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Padding(padding: EdgeInsets.only(left:10,top:10,right: 10,bottom: 10), child: Text("Player:", style: TextStyle(fontSize: 16)),), widget]));
  }

/*Widget _getDropdownButton() async{

    List<PlayerObserved> playersObserved = await playersObservedBloc.playersObservedSubject.value;
    return DropdownButton<String>(
        elevation: 2,
        isDense: true,
        iconSize: 20.0,
        value: _selectedClass,
        items: _classes.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(_formatClassName(value), style: TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (value) {
          _onClassSelected(value);
          setState(() {
            _selectedClass = value;
          });
        });
  }*/
}

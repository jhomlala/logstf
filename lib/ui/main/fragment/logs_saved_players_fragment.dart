import 'package:flutter/material.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/model/internal/player_observed.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/util/error_handler.dart';
import 'package:logstf/ui/main/bloc/logs_saved_players_fragment_bloc.dart';
import 'package:logstf/ui/common/widget/empty_card.dart';
import 'package:logstf/ui/main/widget/log_short_card.dart';
import 'package:logstf/ui/common/widget/progress_bar.dart';

class LogsSavedPlayersFragment extends StatefulWidget {
  final LogsSavedPlayersFragmentBloc logsSavedPlayersFragmentBloc;
  final Function onLogClicked;

  const LogsSavedPlayersFragment(
      this.logsSavedPlayersFragmentBloc, this.onLogClicked);

  @override
  _LogsSavedPlayersFragmentState createState() =>
      _LogsSavedPlayersFragmentState();
}

class _LogsSavedPlayersFragmentState extends State<LogsSavedPlayersFragment>
    with AutomaticKeepAliveClientMixin<LogsSavedPlayersFragment> {
  LogsSavedPlayersFragmentBloc get logsSavedPlayersFragmentBloc =>
      widget.logsSavedPlayersFragmentBloc;
  PlayerObserved _selectedPlayer;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    logsSavedPlayersFragmentBloc.getPlayersObserved();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    super.build(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder(
            stream: logsSavedPlayersFragmentBloc.playersObservedSubject,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Text(applicationLocalization.getText("loading"));
              } else {
                List<PlayerObserved> observedPlayers = snapshot.data;
                if (_selectedPlayer == null && observedPlayers.length > 0) {
                  _selectedPlayer = observedPlayers[0];
                  logsSavedPlayersFragmentBloc
                      .searchLogs(_selectedPlayer.steamid64);
                }
                return Column(children: [
                  _getPlayersChooserCard(
                      snapshot.data, applicationLocalization),
                  StreamBuilder<List<LogShort>>(
                      stream: logsSavedPlayersFragmentBloc.logsSearchSubject,
                      initialData:
                          logsSavedPlayersFragmentBloc.logsSearchSubject.value,
                      builder: (context, snapshot) {
                        if (!logsSavedPlayersFragmentBloc.loading) {
                          if (snapshot.hasError) {
                            return EmptyCard(
                              description: ErrorHandler.handleError(
                                  snapshot.error, context),
                              retry: true,
                              retryAction: _onRetryPressed,
                            );
                          }

                          var data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return EmptyCard(
                              description: applicationLocalization
                                  .getText("logs_players_observed_no_data"),
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
                                            logSearch: data[index],
                                            onLogClicked: widget.onLogClicked,
                                          );
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
        key: Key("logsWatchListViewDropdown"),
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
          logsSavedPlayersFragmentBloc.clearLogs();
          logsSavedPlayersFragmentBloc.searchLogs(value.steamid64);
          setState(() {
            _selectedPlayer = value;
          });
        });
  }

  Widget _getPlayersChooserCard(List<PlayerObserved> playersObserved,
      ApplicationLocalization applicationLocalization) {
    List<Widget> widgets = List();
    if (playersObserved.length > 0) {
      widgets.add(Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
        child: Text(
            applicationLocalization.getText("logs_players_observed_player"),
            style: TextStyle(fontSize: 16)),
      ));
      widgets.add(Row(children: [
        _getPlayersDropdown(playersObserved),
        IconButton(
          key: Key("logsWatchListViewDeleteIconButton"),
          icon: Icon(
            Icons.delete,
            color: Colors.grey,
          ),
          onPressed: () {
            logsSavedPlayersFragmentBloc.deletePlayerObserved(_selectedPlayer);
            logsSavedPlayersFragmentBloc.clearLogs();
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
                applicationLocalization
                    .getText("logs_players_observed_no_observed_players"),
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
          !logsSavedPlayersFragmentBloc.loading) {
        logsSavedPlayersFragmentBloc.searchLogs(_selectedPlayer.steamid64);
      }
    }
    return false;
  }

  _onRetryPressed() {
    logsSavedPlayersFragmentBloc.searchLogs(_selectedPlayer.steamid64);
  }
}

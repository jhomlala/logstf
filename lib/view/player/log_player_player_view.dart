import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/bloc/steam_bloc.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/search_player_matches_navigation_event.dart';
import 'package:logstf/model/steam_player.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/widget/logs_button.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class LogPlayerPlayerView extends StatefulWidget {
  final Player player;
  final Log log;

  LogPlayerPlayerView(this.player, this.log);

  @override
  _LogPlayerPlayerViewState createState() => _LogPlayerPlayerViewState();
}

class _LogPlayerPlayerViewState extends State<LogPlayerPlayerView> {
  BehaviorSubject<int> matchesCountSubject;
  int steamId64;

  @override
  void initState() {
    matchesCountSubject = BehaviorSubject();
    steamId64 = AppUtils.convertSteamId3ToSteamId64(widget.player.steamId);
    print("Getting player with steamId: " + steamId64.toString());
    logsSearchBloc.getPlayerMatchesCount(steamId64.toString()).then((value) {
      matchesCountSubject.value = value;
    });

    print("OOK");
    _getPlayer();
    super.initState();
  }

  _getPlayer() async {
    int steamId64 = AppUtils.convertSteamId3ToSteamId64(widget.player.steamId);
    steamBloc.getSteamPlayer(steamId64.toString());
  }

  @override
  void dispose() {
    matchesCountSubject.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        padding: EdgeInsets.all(10),
        child: StreamBuilder<SteamPlayer>(
            stream: steamBloc.steamPlayerSubject.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return ProgressBar();
              } else {
                SteamPlayer steamPlayer = snapshot.data;
                return Card(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                            child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          ClipOval(
                            child: Image.network(
                              steamPlayer.avatarfull,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "${steamPlayer.personaname}",
                            style: TextStyle(fontSize: 30.0),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                              "(${widget.log.getPlayerName(widget.player.steamId)})",
                              textAlign: TextAlign.center),
                          StreamBuilder<int>(
                            stream: matchesCountSubject.stream,
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 5),
                                    child: Column(children: [
                                      Text(
                                          "Player has ${snapshot.data} matches in history"),
                                      LogsButton(
                                        text: "Matches",
                                        onPressed: _onMatchesClicked,
                                        backgroundColor: Colors.deepPurple,
                                      )
                                    ]));
                              } else {
                                return Container(
                                  width: 0.0,
                                  height: 0.0,
                                );
                              }
                            },
                          ),
                          Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: LogsButton(
                                        text: "Steam",
                                        onPressed: _onSteamClicked,
                                        backgroundColor: Colors.deepOrange,
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: LogsButton(
                                        text: "ETF2L",
                                        onPressed: _onEtf2lClicked,
                                        backgroundColor: Colors.deepOrange,
                                      )),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: LogsButton(
                                        text: "UGC",
                                        onPressed: _onUgcClicked,
                                        backgroundColor: Colors.deepOrange,
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: LogsButton(
                                        text: "TF2Center",
                                        onPressed: _onTf2CenterClicked,
                                        backgroundColor: Colors.deepOrange,
                                      )),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: LogsButton(
                                        text: "OzFortress",
                                        onPressed: _onOzFortressClicked,
                                        backgroundColor: Colors.deepOrange,
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: LogsButton(
                                        text: "RGL",
                                        onPressed: _onRglClicked,
                                        backgroundColor: Colors.deepOrange,
                                      )),
                                ]),
                          ])
                        ]))));
                //return Text("Player: " + snapshot.data.toString());
              }
            }));
  }

  void _onMatchesClicked() {
    Navigator.pop(
        context, SearchPlayerMatchesNavigationEvent(steamId64.toString()));
  }

  void _onSteamClicked() {
    _launchWebPage("http://steamcommunity.com/profiles/$steamId64");
  }

  void _onEtf2lClicked() {
    _launchWebPage("http://etf2l.org/search/$steamId64");
  }

  void _onUgcClicked() {
    _launchWebPage("http://www.ugcleague.com/players_page.cfm?player_id=$steamId64");
  }

  void _onTf2CenterClicked() {
    _launchWebPage("http://tf2center.com/profile/$steamId64");
  }

  void _onOzFortressClicked() {
    _launchWebPage("http://warzone.ozfortress.com/users/steam_id/$steamId64");
  }

  void _onRglClicked() {
    _launchWebPage("http://rgl.gg/Public/PlayerProfile.aspx?p=$steamId64");
  }

  _launchWebPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

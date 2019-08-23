import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/bloc/players_observed_bloc.dart';
import 'package:logstf/bloc/steam_bloc.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/model/search_player_matches_navigation_event.dart';
import 'package:logstf/model/steam_player.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/view/report/report_generator_view.dart';
import 'package:logstf/widget/logs_button.dart';
import 'package:logstf/widget/observe_player_button.dart';
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

class _LogPlayerPlayerViewState extends State<LogPlayerPlayerView>
    with AutomaticKeepAliveClientMixin<LogPlayerPlayerView> {
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
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                      ),
                                      Row(children: [
                                        _getPageButton(
                                            "Matches", _onMatchesClicked,
                                            backgroundColor: Colors.deepPurple)
                                      ]),
                                      Row(children: [
                                        ObservePlayerButton(
                                          steamId64: steamId64.toString(),
                                          playerName: widget.log.getPlayerName(
                                              widget.player.steamId),
                                        ),
                                      ]),
                                      Row(children: [
                                        _getPageButton(
                                            "Generate report", _onGenerateReportClicked,
                                            backgroundColor: Colors.deepPurple)
                                      ]),
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
                                  _getPageButton("Steam", _onSteamClicked),
                                  _getPageButton("ETF2L", _onEtf2lClicked)
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _getPageButton("UGC", _onUgcClicked),
                                  _getPageButton(
                                      "TF2Center", _onTf2CenterClicked)
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  _getPageButton(
                                      "OzFortress", _onOzFortressClicked),
                                  _getPageButton("RGL", _onRglClicked)
                                ]),
                          ])
                        ]))));
                //return Text("Player: " + snapshot.data.toString());
              }
            }));
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
    PlayerObserved playerObserved =
        await playersObservedBloc.getPlayerObserved(steamId64.toString());
    if (playerObserved == null) {
      playerObserved = PlayerObserved(
          id: DateTime.now().millisecondsSinceEpoch,
          name: widget.log.getPlayerName(widget.player.steamId),
          steamid64: steamId64.toString());
      await playersObservedBloc.addPlayerObserved(playerObserved);
    }
  }

  void _removeObservedPlayer() async {
    PlayerObserved playerObserved =
        await playersObservedBloc.getPlayerObserved(steamId64.toString());
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
    _launchWebPage(
        "http://www.ugcleague.com/players_page.cfm?player_id=$steamId64");
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

  _onGenerateReportClicked(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReportGeneratorView(player: widget.player, steamId64: steamId64.toString(),)));

  }

  @override
  bool get wantKeepAlive => true;
}

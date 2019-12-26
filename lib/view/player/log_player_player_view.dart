import 'package:flutter/material.dart';
import 'package:logstf/view/main/main_page_bloc.dart';
import 'package:logstf/bloc/steam_bloc.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/search_player_matches_navigation_event.dart';
import 'package:logstf/model/steam_player.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/widget/logs_button.dart';
import 'package:logstf/widget/observe_player_button.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:rxdart/rxdart.dart';

class LogPlayerPlayerView extends StatefulWidget {
  final Player player;
  final Log log;

  LogPlayerPlayerView(this.player, this.log);

  @override
  _LogPlayerPlayerViewState createState() => _LogPlayerPlayerViewState();
}

class _LogPlayerPlayerViewState extends State<LogPlayerPlayerView>
    with AutomaticKeepAliveClientMixin<LogPlayerPlayerView> {
  BehaviorSubject<int> _matchesCountSubject = BehaviorSubject();
  int _steamId64;

  @override
  void initState() {
    _steamId64 = AppUtils.convertSteamId3ToSteamId64(widget.player.steamId);
    logsSearchBloc.getPlayerMatchesCount(_steamId64.toString()).then((value) {
      _matchesCountSubject.value = value;
    });
    _getPlayer();
    super.initState();
  }

  _getPlayer() async {
    int steamId64 = AppUtils.convertSteamId3ToSteamId64(widget.player.steamId);
    steamBloc.getSteamPlayer(steamId64.toString());
  }

  @override
  void dispose() {
    _matchesCountSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    super.build(context);
    return Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: StreamBuilder<SteamPlayer>(
            stream: steamBloc.steamPlayerSubject.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return ProgressBar();
              } else {
                SteamPlayer steamPlayer = snapshot.data;
                return SingleChildScrollView(
                    child: Card(
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
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
                                stream: _matchesCountSubject.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        child: Column(children: [
                                          Text(applicationLocalization.getText("log_player_logs_tf_matches").replaceAll("<matches_count>", snapshot.data.toString())),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                          ),
                                          Row(children: [
                                            _getPageButton(
                                  applicationLocalization.getText("log_player_matches"), _onMatchesClicked,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor)
                                          ]),
                                          Row(children: [
                                            ObservePlayerButton(
                                              steamId64: _steamId64.toString(),
                                              playerName: widget.log
                                                  .getPlayerName(
                                                      widget.player.steamId),
                                            ),
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

  void _onMatchesClicked() {
    Navigator.pop(
        context, SearchPlayerMatchesNavigationEvent(_steamId64.toString()));
  }

  void _onSteamClicked() {
    AppUtils.launchWebPage("${AppConst.steamProfileUrl}$_steamId64");
  }

  void _onEtf2lClicked() {
    AppUtils.launchWebPage("${AppConst.etf2lProfileUrl}$_steamId64");
  }

  void _onUgcClicked() {
    AppUtils.launchWebPage("${AppConst.ugcProfileUrl}$_steamId64");
  }

  void _onTf2CenterClicked() {
    AppUtils.launchWebPage("${AppConst.tf2CenterProfileUrl}$_steamId64");
  }

  void _onOzFortressClicked() {
    AppUtils.launchWebPage("${AppConst.ozFortressProfileUrl}$_steamId64");
  }

  void _onRglClicked() {
    AppUtils.launchWebPage("${AppConst.rglProfileUrl}$_steamId64");
  }

  @override
  bool get wantKeepAlive => true;
}

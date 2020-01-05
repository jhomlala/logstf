import 'package:flutter/material.dart';
import 'package:logstf/model/internal/player_observed.dart';
import 'package:logstf/util/application_localization.dart';

import '../../common/widget/logs_button.dart';

class ObservePlayerButton extends StatefulWidget {
  final Future<PlayerObserved> playerObserved;
  final String steamId64;
  final String playerName;
  final Function onObservePlayerClicked;
  final Function onRemovePlayerObserveClicked;

  const ObservePlayerButton(
      {Key key,
      this.steamId64,
      this.playerName,
      this.playerObserved,
      this.onObservePlayerClicked,
      this.onRemovePlayerObserveClicked})
      : super(key: key);

  @override
  _ObservePlayerButtonState createState() => _ObservePlayerButtonState();
}

class _ObservePlayerButtonState extends State<ObservePlayerButton> {
  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return FutureBuilder(
        future: widget.playerObserved,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return _getPageButton("", () {});
          } else if (snapshot.connectionState == ConnectionState.done) {
            PlayerObserved snapshotData = snapshot.data as PlayerObserved;
            if (snapshotData != null) {
              return _getPageButton(
                  applicationLocalization.getText("log_player_observe_remove"),
                  _removeObservedPlayer,
                  backgroundColor: Theme.of(context).primaryColor);
            } else {
              return _getPageButton(
                  applicationLocalization.getText("log_player_observe"),
                  _observePlayer,
                  backgroundColor: Theme.of(context).primaryColor);
            }
          } else {
            return _getPageButton("", () {});
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
    widget.onObservePlayerClicked(widget.steamId64, widget.playerName);
  }

  void _removeObservedPlayer() async {
    widget.onRemovePlayerObserveClicked(widget.steamId64);
  }
}

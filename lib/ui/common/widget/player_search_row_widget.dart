import 'package:flutter/material.dart';
import 'package:logstf/model/player_search_result.dart';
import 'package:logstf/ui/common/widget/logs_button.dart';

class PlayerSearchRowWidget extends StatefulWidget {
  final PlayerSearchResult playerSearchResult;
  final Function onObservePlayerClicked;
  final Function onSearchLogsClicked;
  final bool isObserved;

  const PlayerSearchRowWidget(this.playerSearchResult,
      this.onObservePlayerClicked, this.onSearchLogsClicked, this.isObserved);

  @override
  State<StatefulWidget> createState() {
    return _PlayerSearchRowWidgetState();
  }
}

class _PlayerSearchRowWidgetState extends State<PlayerSearchRowWidget> {
  bool isObserved = false;

  @override
  void initState() {
    isObserved = widget.isObserved;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
          margin: EdgeInsets.all(5),
          child: Column(children: [
            Row(children: [
              _getImage(widget.playerSearchResult.avatarUrl),
              Padding(padding: EdgeInsets.only(left: 5)),
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: Text(
                    widget.playerSearchResult.playerNames.join(", "),
                    maxLines: 5,
                  ))
            ]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getPlayerActionWidgets())
          ])),
    );
  }

  List<Widget> _getPlayerActionWidgets() {
    List<Widget> list = List();
    if (isObserved) {
      list.add(Text("Player is observed"));
    } else {
      list.add(LogsButton(
          text: "Observe player",
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          onPressed: () => _onObservePlayerClicked(context)
      ));
    }
    list.add(Padding(
      padding: EdgeInsets.only(left: 10),
    ));
    list.add(LogsButton(
      text: "Search logs with player",
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      onPressed: () => widget.onSearchLogsClicked(widget.playerSearchResult),
    ));
    return list;
  }

  Widget _getImage(String url) {
    if (url != null) {
      return Image.network(widget.playerSearchResult.avatarUrl);
    } else {
      return Image.asset("assets/tf2logo.png", width: 32, height: 32);
    }
  }

  void _onObservePlayerClicked(BuildContext context) {
    setState(() {
      isObserved = true;
    });
    widget.onObservePlayerClicked(widget.playerSearchResult);
  }
}

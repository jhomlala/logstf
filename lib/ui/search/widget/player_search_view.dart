import 'package:flutter/material.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/ui/search/page/player_search_results_page.dart';
import 'package:logstf/widget/logs_button.dart';

class PlayerSearchView extends StatefulWidget {
  final Function playerSearchAction;

  const PlayerSearchView(this.playerSearchAction);

  @override
  _PlayerSearchViewState createState() => _PlayerSearchViewState();
}

class _PlayerSearchViewState extends State<PlayerSearchView> {
  final TextEditingController _playerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: ListView(children: [
          Card(
              margin: EdgeInsets.all(10),
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Form(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextFormField(
                      key: Key("Player"),
                      controller: _playerNameController,
                      decoration: InputDecoration(
                          hintText: applicationLocalization
                              .getText("log_search_player_name"),
                          labelText: applicationLocalization
                              .getText("log_search_player_name")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    LogsButton(
                      text:
                          applicationLocalization.getText("log_search_search"),
                      onPressed: _onSearchClicked,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ]))))
        ]));
  }

  void _onSearchClicked() async {
    widget.playerSearchAction(_playerNameController.text);
  }
}

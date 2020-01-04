import 'package:flutter/material.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/ui/common/widget/logs_button.dart';

class PlayerSearchFragment extends StatefulWidget {
  final Function playerSearchAction;

  const PlayerSearchFragment(this.playerSearchAction);

  @override
  _PlayerSearchFragmentState createState() => _PlayerSearchFragmentState();
}

class _PlayerSearchFragmentState extends State<PlayerSearchFragment> {
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

import 'package:flutter/material.dart';
import 'package:logstf/view/logs/search/player_search_results_view.dart';
import 'package:logstf/widget/logs_button.dart';

class PlayerSearchView extends StatefulWidget {
  @override
  _PlayerSearchViewState createState() => _PlayerSearchViewState();
}

class _PlayerSearchViewState extends State<PlayerSearchView> {
  final TextEditingController _playerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: ListView(children: [
          Card(
              margin: EdgeInsets.all(10),
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Form(
                      key: Key("aaa"),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        TextFormField(
                          key: Key("Player"),
                          controller: _playerNameController,
                          decoration: InputDecoration(
                              hintText: 'Player name',
                              labelText: 'Player name'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        LogsButton(
                          text: "Search",
                          onPressed: _onSearchClicked,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ]))))
        ]));
  }

  void _onSearchClicked() async{
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlayerSearchResultsView(
                playerName: _playerNameController.text)));

  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help")),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(children: _getHelpWidgets(context))),
    );
  }

  List<Widget> _getHelpWidgets(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(_getHelpQuestion(context, "How MVP is calculated",
        "Each person is evaluated based on his stats. Here is calculation formula: kills * 0.39 + assists * 0.2 + damage * 0.01 + caps * 0.2 + medic kills * 0.2."));
    widgets.add(_getHelpQuestion(context, "I have found bug!",
        "Nice! You can report it to developer. Please go to project page and report issue there (you can find project page in 'About' section)."));
    widgets.add(_getHelpQuestion(context, "How I can help?",
        "You can share ideas with developers in project page or steam."));
    widgets.add(_getHelpQuestion(context, "Is this app free?",
        "Yes, this app is free and will be free forever! If you appreciate this app, you can donate steam items to authors."));
    widgets.add(_getHelpQuestion(context, "What is purpose of this app?",
        "This app is dedicated for professional competetive Team Fortress 2 players, who want to see stats from their matches."));
    widgets.add(_getHelpQuestion(context, "How do you get data?", "All data is from logs.tf website."));
    return widgets;
  }

  Widget _getHelpQuestion(
      BuildContext context, String title, String description) {
    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: ExpandablePanel(
            header: Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(title, style: TextStyle(fontSize: 20)))),
            expanded: Container(
                width: MediaQuery.of(context).size.width - 20,
                padding: EdgeInsets.all(10),
                child: Text(
                  description,
                  maxLines: 50,
                ))));
  }
}

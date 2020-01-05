import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HelpQuestionWidget extends StatelessWidget {
  final String title;
  final String description;

  const HelpQuestionWidget(this.title, this.description);

  @override
  Widget build(BuildContext context) {
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

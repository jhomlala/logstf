import 'package:flutter/material.dart';
import 'package:logstf/utils/application_localization.dart';

import 'logs_button.dart';

class EmptyCard extends StatelessWidget {
  final String description;
  final bool retry;
  final Function retryAction;

  const EmptyCard(
      {Key key, this.description, this.retry = false, this.retryAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Container(
        child: Column(children: [
      Card(
          margin: EdgeInsets.all(10),
          child: Container(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 200,
                        child: Text(
                          description,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
                retry
                    ? Container(
                        padding: EdgeInsets.only(top: 30),
                        child: LogsButton(
                          text: applicationLocalization.getText("retry"),
                          onPressed: retryAction,
                          backgroundColor: Theme.of(context).primaryColor,
                        ))
                    : Container()
              ])))
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class LogShortCard extends StatelessWidget {
  final LogShort logSearch;

  const LogShortCard({Key key, this.logSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LogView(logId: logSearch.id)));
        },
        child: Card(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Container(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                  Row(children: [
                    Text("#${logSearch.id}",
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ]),
                  Row(children: [
                    Text(logSearch.title, style: TextStyle(fontSize: 20)),

                  ]),
                  Row(children: [
                    Icon(
                      Icons.date_range,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2),
                    ),
                    Text(
                        timeago.format(DateTime.fromMillisecondsSinceEpoch(
                            logSearch.date * 1000)),
                        style: TextStyle(fontSize: 14)),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2),
                    ),
                    Text("${logSearch.views}", style: TextStyle(fontSize: 14)),

                  ]),
                  Row(children: [
                    Icon(
                      Icons.map,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2),
                    ),
                    Text(logSearch.map, style: TextStyle(fontSize: 14))
                  ]),
                  Row(children: [
                    Image.asset(
                      "assets/battle.png",
                      width: 14,
                      height: 14,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2),
                    ),
                    Text(
                      LogHelper.getGameType(logSearch.players, logSearch.map),
                      style: TextStyle(fontSize: 14),
                    )
                  ]),
                ]))));
  }
}

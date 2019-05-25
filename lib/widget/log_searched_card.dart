import 'package:flutter/material.dart';
import 'package:logstf/model/log_search.dart';
import 'package:timeago/timeago.dart' as timeago;

class LogSearchedCard extends StatelessWidget {
  final LogSearch logSearch;

  const LogSearchedCard({Key key, this.logSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Container(
            padding: EdgeInsets.all(5),
            child: Column(children: [
              Row(children: [
                Text("#${logSearch.id}",
                    style: TextStyle(fontSize: 12, color: Colors.grey))
              ]),
              Row(children: [
                Text(logSearch.title, style: TextStyle(fontSize: 20))
              ]),
              Row(children: [
                Icon(Icons.date_range, size: 14, color: Colors.grey,),
                Padding(padding: EdgeInsets.only(left: 2),),
                Text(
                    timeago.format(DateTime.fromMillisecondsSinceEpoch(
                        logSearch.date * 1000)),
                    style: TextStyle(fontSize: 14)),
                Padding(padding: EdgeInsets.only(left: 5),),
                Icon(Icons.remove_red_eye, size: 14, color: Colors.grey,),
                Padding(padding: EdgeInsets.only(left: 2),),
                Text("${logSearch.views}",
                    style: TextStyle(fontSize: 14))
              ]),
              Row(children: [  Icon(Icons.map, size: 14, color: Colors.grey,),
              Padding(padding: EdgeInsets.only(left: 2),),
                Text(logSearch.map, style: TextStyle(fontSize: 14))
              ]),
            ])));
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/log_searched.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/widget/log_searched_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:provider/provider.dart';

import 'logs_search_view.dart';

class LogsListView extends StatefulWidget {
  @override
  _LogsListViewState createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView> {
  LogsSearchBloc logsSearchBloc;
  int _refresh;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logsSearchBloc = Provider.of<LogsSearchBloc>(context);
    logsSearchBloc.initLogs();
    return Container(
            color: Colors.deepPurple,
            child: StreamBuilder<List<LogSearched>>(
                stream: logsSearchBloc.logsSearchSubject.stream,
                builder: (context, snapshot) {
                  if (!logsSearchBloc.loading) {
                    print("Building list view!");
                    var data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return _getLogsEmptyWidget();
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, position) {
                            return LogSearchedCard(logSearch: data[position]);
                          });
                    }
                  } else {
                    print("Show progress");
                    return Container(
                        decoration: BoxDecoration(color: Colors.deepPurple),
                        child: Center(
                            child:
                                Container(height: 40, child: ProgressBar())));
                  }
                }));
  }

  Widget _getLogsEmptyWidget() {
    return Container(
        child: Column(children: [
      Card(
          margin: EdgeInsets.all(10),
          child: Container(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 200,
                        child: Text(
                          "No logs found for selected criteria. Please change criteria or retry request.",
                          textAlign: TextAlign.center,
                          maxLines: 5,
                        ))
                  ],
                ),
                RaisedButton(
                  color: Colors.grey,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Text(
                    "Retry",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    logsSearchBloc.searchLogs();
                    setState(() {
                      _refresh = DateTime.now().millisecondsSinceEpoch;
                    });

                  },
                ),
              ])))
    ]));
    /*return Column(children: [
      Card(
          child: Column(children: [
        Icon(Icons.clear),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              child: Text(
            "No logs found for selected criteria. Please change criteria or retry request.",
            maxLines: 3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ))
        ])
      ])),
      Expanded(child: Container())
    ]);*/
  }
}

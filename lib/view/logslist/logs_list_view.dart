import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/widget/log_searched_card.dart';
import 'package:logstf/widget/progress_bar.dart';

import 'logs_search_view.dart';

class LogsListView extends StatefulWidget {
  @override
  _LogsListViewState createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView> {
  LogsSearchBloc logsSearchBloc;

  @override
  void initState() {
    logsSearchBloc = LogsSearchBloc();
    logsSearchBloc.searchLogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Logs TF"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogsSearchView()));
              },
            )
          ],
        ),
        body:
        Container(color: Colors.deepPurple, child: StreamBuilder<LogsSearchResponse>(
            stream: logsSearchBloc.logsSearchSubject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.logs.length,
                    itemBuilder: (context, position) {
                      return LogSearchedCard(
                          logSearch: snapshot.data.logs[position]);
                    });
              } else {
                return Container(
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    child: Center(
                        child: Container(height: 40, child: ProgressBar())));
              }
            })));
  }
}

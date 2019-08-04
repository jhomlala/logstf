import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:provider/provider.dart';

import 'package:logstf/view/logs/search/logs_search_view.dart';

class LogsListView extends StatefulWidget {
  @override
  _LogsListViewState createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView> with AutomaticKeepAliveClientMixin<LogsListView>  {
  @override
  void initState() {
    logsSearchBloc.initLogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
            color: Colors.deepPurple,
            child: StreamBuilder<List<LogShort>>(
                stream: logsSearchBloc.logsSearchSubject.stream,
                initialData: logsSearchBloc.logsSearchSubject.value,
                builder: (context, snapshot) {
                  if (!logsSearchBloc.loading) {
                    var data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return EmptyCard(description: "There's no logs found.");
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, position) {
                            if (data[position].id == -1){
                              return Card(
                                  margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                  child: Text("Search filters are on"));
                            }
                            return LogShortCard(logSearch: data[position]);
                          });
                    }
                  } else {
                    return ProgressBar();
                  }
                }));
  }

  @override
  bool get wantKeepAlive => true;

}

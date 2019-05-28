import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:provider/provider.dart';

import 'logs_search_view.dart';

class LogsListView extends StatefulWidget {
  @override
  _LogsListViewState createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView> with AutomaticKeepAliveClientMixin<LogsListView>  {
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
            child: StreamBuilder<List<LogShort>>(
                stream: logsSearchBloc.logsSearchSubject.stream,
                builder: (context, snapshot) {
                  if (!logsSearchBloc.loading) {
                    print("Building list view!");
                    var data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return EmptyCard(description: "There's no logs found");
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, position) {
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

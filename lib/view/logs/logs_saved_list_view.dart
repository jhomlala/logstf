import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/logs_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:provider/provider.dart';

class LogsSavedListView extends StatefulWidget {
  @override
  _LogsSavedListViewState createState() => _LogsSavedListViewState();
}

class _LogsSavedListViewState extends State<LogsSavedListView> with AutomaticKeepAliveClientMixin<LogsSavedListView> {
  LogsBloc logsBloc;

  @override
  Widget build(BuildContext context) {
    if (logsBloc == null) {
      print("logs bloc is null!");
      logsBloc = Provider.of<LogsBloc>(context);
      logsBloc.getSavedLogs();
    }

    return Container(
        color: Colors.deepPurple,
        child: StreamBuilder<List<LogShort>>(
            stream: logsBloc.savedLogsSubject,
            builder: (context, snapshot) {
              if (!logsBloc.savedLogsLoading){
                var data = snapshot.data;
                if (data == null || data.isEmpty){
                  return EmptyCard(
                    description: "There's no saved data. ",
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return LogShortCard(logSearch: data[index]);
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

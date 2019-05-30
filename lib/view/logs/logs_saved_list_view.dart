import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/logs_saved_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:provider/provider.dart';

class LogsSavedListView extends StatefulWidget {
  @override
  _LogsSavedListViewState createState() => _LogsSavedListViewState();
}

class _LogsSavedListViewState extends State<LogsSavedListView>
    with AutomaticKeepAliveClientMixin<LogsSavedListView> {
  @override
  void initState() {
    logsSavedBloc.initLogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("[LOGS_SAVED] Building! " + logsSavedBloc.loading.toString());
    return Container(
        color: Colors.deepPurple,
        child: StreamBuilder<List<LogShort>>(
            stream: logsSavedBloc.savedLogsSubject,
            initialData: logsSavedBloc.savedLogsSubject.value,
            builder: (context, snapshot) {
              if (!logsSavedBloc.loading) {
                var data = snapshot.data;
                if (data == null || data.isEmpty) {
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

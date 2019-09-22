import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/logs_saved_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';

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
    var applicationLocalization = ApplicationLocalization.of(context);
    super.build(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder<List<LogShort>>(
            stream: logsSavedBloc.savedLogsSubject,
            initialData: logsSavedBloc.savedLogsSubject.value,
            builder: (context, snapshot) {
              if (!logsSavedBloc.loading) {
                var data = snapshot.data;
                if (data == null || data.isEmpty) {
                  return EmptyCard(
                    description:
                        applicationLocalization.getText("logs_saved_no_data"),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(data[index].id.toString()),
                          child: LogShortCard(logSearch: data[index]),
                          onDismissed: (direction) {
                            logsSavedBloc.deleteSavedLog(data[index].id);
                            logsSavedBloc.removeLog(data[index]);
                          },
                        );
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

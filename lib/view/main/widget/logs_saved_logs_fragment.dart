import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/view/main/bloc/logs_saved_logs_fragment_bloc.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';

class LogsSavedLogsFragment extends StatefulWidget {
  final LogsSavedLogsFragmentBloc logsSavedLogsFragmentBloc;

  const LogsSavedLogsFragment(this.logsSavedLogsFragmentBloc);

  @override
  _LogsSavedLogsFragmentState createState() => _LogsSavedLogsFragmentState();
}

class _LogsSavedLogsFragmentState extends State<LogsSavedLogsFragment>
    with AutomaticKeepAliveClientMixin<LogsSavedLogsFragment> {
  LogsSavedLogsFragmentBloc get logsSavedLogsFragmentBloc =>
      widget.logsSavedLogsFragmentBloc;

  @override
  void initState() {
    logsSavedLogsFragmentBloc.initLogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    super.build(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder<List<LogShort>>(
            stream: logsSavedLogsFragmentBloc.savedLogsSubject,
            initialData: logsSavedLogsFragmentBloc.savedLogsSubject.value,
            builder: (context, snapshot) {
              if (!logsSavedLogsFragmentBloc.loading) {
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
                            logsSavedLogsFragmentBloc
                                .deleteSavedLog(data[index].id);
                            logsSavedLogsFragmentBloc.removeLog(data[index]);
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

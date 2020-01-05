import 'dart:async';

import 'package:logstf/model/internal/saved_log_added_event.dart';
import 'package:logstf/model/internal/saved_logs_clear_event.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/repository/internal/logs_local_provider.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/ui/common/base_bloc.dart';
import 'package:logstf/ui/common/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogsSavedLogsFragmentBloc extends BaseBloc {
  final BehaviorSubject<List<LogShort>> savedLogsSubject = BehaviorSubject();
  final LogsLocalProvider logsLocalProvider;
  var loading = false;

  LogsSavedLogsFragmentBloc(this.logsLocalProvider) {
    StreamSubscription logSavedEventSubscription =
        RxBus.register<LogSavedEvent>().listen((event) {
      clearLogs();
      getSavedLogs();
    });
    addSubscription(logSavedEventSubscription);

    StreamSubscription savedLogsClearEventSubscription =
        RxBus.register<SavedLogsClearEvent>().listen((event) {
          clearLogs();
        });
    addSubscription(savedLogsClearEventSubscription);
  }

  void dispose() async {
    await savedLogsSubject.drain();
    savedLogsSubject.close();
  }

  void saveLog(LogShort log) {
    logsLocalProvider.createLog(log);
  }

  Future<LogShort> getSavedLog(int logId) {
    return logsLocalProvider.getLog(logId);
  }

  void deleteSavedLog(int logId) async {
    await logsLocalProvider.deleteLog(logId);
  }

  void getSavedLogs() async {
    savedLogsSubject.value = await logsLocalProvider.getLogs();
  }

  void initLogs() {
    if (loading) {
      return;
    }
    if (savedLogsSubject.value == null) {
      getSavedLogs();
    }
  }

  void addLog(LogShort logShort) {
    var savedLogs = savedLogsSubject.value;
    savedLogs.add(logShort);
    savedLogsSubject.add(savedLogs);
  }

  void removeLog(LogShort logShortToFind) {
    var savedLogs = savedLogsSubject.value;
    savedLogs.removeWhere((logShort) => logShort.id == logShortToFind.id);
    savedLogsSubject.value = savedLogs;
  }

  void clearLogs() {
    savedLogsSubject.value = List();
  }

  void deleteSavedLogs() async {
    await logsLocalProvider.deleteLogs();
    clearLogs();
  }
}

class LogsSavedLogsFragmentBlocProvider
    extends BlocProvider<LogsSavedLogsFragmentBloc> {
  final LogsLocalProvider logsLocalProvider;

  LogsSavedLogsFragmentBlocProvider(this.logsLocalProvider);

  @override
  LogsSavedLogsFragmentBloc create() {
    return LogsSavedLogsFragmentBloc(logsLocalProvider);
  }
}

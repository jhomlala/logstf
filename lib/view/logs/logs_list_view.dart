import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/util/error_handler.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/filters_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';

class LogsListView extends StatefulWidget {
  @override
  _LogsListViewState createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView>
    with AutomaticKeepAliveClientMixin<LogsListView> {
  ScrollController _controller;

  @override
  void initState() {
    logsSearchBloc.initLogs();
    _controller = new ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder<List<LogShort>>(
            stream: logsSearchBloc.logsSearchSubject.stream,
            initialData: logsSearchBloc.logsSearchSubject.value,
            builder: (context, snapshot) {
              List<Widget> widgets = List();
              if (logsSearchBloc.isAnyFilterActive()) {
                widgets.add(Card(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: ExpandablePanel(
                      header: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 50,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Active Filters",
                                  style: TextStyle(fontSize: 24)))),
                      expanded: FiltersCard(
                        map: logsSearchBloc.map,
                        uploader: logsSearchBloc.uploader,
                        title: logsSearchBloc.title,
                        player: logsSearchBloc.player,
                      ),
                    )));
              }

              if (!logsSearchBloc.loading) {
                if (snapshot.hasError) {
                  widgets.add(EmptyCard(
                      description: ErrorHandler.handleError(snapshot.error)));
                } else {
                  var data = snapshot.data;
                  if (data == null || data.isEmpty) {
                    widgets
                        .add(EmptyCard(description: "There's no logs found."));
                  } else {
                    widgets.add(Expanded(
                        child: NotificationListener<ScrollNotification>(
                            onNotification: _handleScrollNotification,
                            child: ListView.builder(
                                itemCount: data.length,
                                controller: _controller,
                                itemBuilder: (context, position) {
                                  return LogShortCard(
                                      logSearch: data[position]);
                                }))));
                  }
                }
              } else {
                widgets.add(Expanded(child: Center(child: ProgressBar())));
              }
              return Column(children: widgets);
            }));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_controller.position.extentAfter == 0 && !logsSearchBloc.loading) {
        logsSearchBloc.searchLogs(
            map: logsSearchBloc.map,
            player: logsSearchBloc.player,
            uploader: logsSearchBloc.uploader,
            title: logsSearchBloc.title);
      }
    }
    return false;
  }

  @override
  bool get wantKeepAlive => true;
}

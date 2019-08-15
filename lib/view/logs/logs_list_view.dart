import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/filters_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:provider/provider.dart';

import 'package:logstf/view/logs/search/logs_search_view.dart';

class LogsListView extends StatefulWidget {
  @override
  _LogsListViewState createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView>
    with AutomaticKeepAliveClientMixin<LogsListView> {
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
                var data = snapshot.data;
                if (data == null || data.isEmpty) {
                  widgets.add(EmptyCard(description: "There's no logs found."));
                } else {
                  widgets.add(Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, position) {
                            return LogShortCard(logSearch: data[position]);
                          })));
                }
              } else {
                widgets.add(Expanded(child: Center(child: ProgressBar())));
              }

              return Column(children: widgets);
            }));
  }

  @override
  bool get wantKeepAlive => true;
}

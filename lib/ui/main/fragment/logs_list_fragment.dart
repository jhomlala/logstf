import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:logstf/ui/main/bloc/logs_list_fragment_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/util/error_handler.dart';
import 'package:logstf/ui/common/widget/empty_card.dart';
import 'package:logstf/ui/main/widget/filters_card.dart';
import 'package:logstf/ui/main/widget/log_short_card.dart';
import 'package:logstf/ui/common/widget/progress_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LogsListFragment extends StatefulWidget {
  final LogsListFragmentBloc logsListFragmentBloc;
  final Function onLogClicked;

  LogsListFragment(this.logsListFragmentBloc, this.onLogClicked);

  @override
  _LogsListFragmentState createState() => _LogsListFragmentState();
}

class _LogsListFragmentState extends State<LogsListFragment>
    with AutomaticKeepAliveClientMixin<LogsListFragment> {
  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  LogsListFragmentBloc get logsListFragmentBloc => widget.logsListFragmentBloc;

  void _onRefresh() async {
    await logsListFragmentBloc.searchLogs(clearLogs: true);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    logsListFragmentBloc.initLogs();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    super.build(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder<List<LogShort>>(
            stream: logsListFragmentBloc.logsSearchSubject.stream,
            initialData: logsListFragmentBloc.logsSearchSubject.value,
            builder: (context, snapshot) {
              List<Widget> widgets = List();
              if (logsListFragmentBloc.isAnyFilterActive()) {
                widgets.add(Card(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: ExpandablePanel(
                      header: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 50,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  applicationLocalization
                                      .getText("logs_active_filters"),
                                  style: TextStyle(fontSize: 24)))),
                      expanded: FiltersCard(
                        map: logsListFragmentBloc.map,
                        uploader: logsListFragmentBloc.uploader,
                        title: logsListFragmentBloc.title,
                        player: logsListFragmentBloc.player,
                        onClearClicked: _onClearClicked,
                      ),
                    )));
              }

              if (!logsListFragmentBloc.loading) {
                if (snapshot.hasError) {
                  print("Error: " + snapshot.error.toString());
                  widgets.add(EmptyCard(
                    description:
                        ErrorHandler.handleError(snapshot.error, context),
                    retry: true,
                    retryAction: _onRetryPressed,
                  ));
                } else {
                  var data = snapshot.data;
                  if (data == null || data.isEmpty) {
                    widgets.add(EmptyCard(
                        description: applicationLocalization
                            .getText("logs_no_logs_found")));
                  } else {
                    widgets.add(Expanded(
                        child: NotificationListener<ScrollNotification>(
                            onNotification: _handleScrollNotification,
                            child: SmartRefresher(
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                header: CustomHeader(
                                  builder: (BuildContext context,
                                      RefreshStatus mode) {
                                    return Container(
                                        margin: EdgeInsets.all(10),
                                        child: ProgressBar());
                                  },
                                ),
                                child: ListView.builder(
                                    itemCount: data.length,
                                    controller: _scrollController,
                                    itemBuilder: (context, position) {
                                      return LogShortCard(
                                        logSearch: data[position],
                                        onLogClicked: widget.onLogClicked,
                                      );
                                    })))));
                  }
                }
              } else {
                widgets.add(Expanded(child: Center(child: ProgressBar())));
              }
              return Column(children: widgets);
            }));
  }

  _onClearClicked() {
    logsListFragmentBloc.clearFilters();
    logsListFragmentBloc.searchLogs();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_scrollController.position.extentAfter == 0 &&
          !logsListFragmentBloc.loading) {
        logsListFragmentBloc.searchLogs(
            map: logsListFragmentBloc.map,
            player: logsListFragmentBloc.player,
            uploader: logsListFragmentBloc.uploader,
            title: logsListFragmentBloc.title);
      }
    }
    return false;
  }

  @override
  bool get wantKeepAlive => true;

  _onRetryPressed() {
    logsListFragmentBloc.searchLogs(
        map: logsListFragmentBloc.map,
        player: logsListFragmentBloc.player,
        uploader: logsListFragmentBloc.uploader,
        title: logsListFragmentBloc.title);
  }
}

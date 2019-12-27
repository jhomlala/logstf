import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:logstf/view/main/bloc/main_page_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/util/error_handler.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/filters_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LogsListView extends StatefulWidget {
  final MainPageBloc mainPageBloc;
  final Function onLogClicked;

  LogsListView(this.mainPageBloc, this.onLogClicked);

  @override
  _LogsListViewState createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView>
    with AutomaticKeepAliveClientMixin<LogsListView> {
  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  MainPageBloc get mainPageBloc => widget.mainPageBloc;

  void _onRefresh() async {
    await mainPageBloc.searchLogs(clearLogs: true);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    mainPageBloc.initLogs();
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
            stream: mainPageBloc.logsSearchSubject.stream,
            initialData: mainPageBloc.logsSearchSubject.value,
            builder: (context, snapshot) {
              List<Widget> widgets = List();
              if (mainPageBloc.isAnyFilterActive()) {
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
                        map: mainPageBloc.map,
                        uploader: mainPageBloc.uploader,
                        title: mainPageBloc.title,
                        player: mainPageBloc.player,
                      ),
                    )));
              }

              if (!mainPageBloc.loading) {
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

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_scrollController.position.extentAfter == 0 &&
          !mainPageBloc.loading) {
        mainPageBloc.searchLogs(
            map: mainPageBloc.map,
            player: mainPageBloc.player,
            uploader: mainPageBloc.uploader,
            title: mainPageBloc.title);
      }
    }
    return false;
  }

  @override
  bool get wantKeepAlive => true;

  _onRetryPressed() {
    mainPageBloc.searchLogs(
        map: mainPageBloc.map,
        player: mainPageBloc.player,
        uploader: mainPageBloc.uploader,
        title: mainPageBloc.title);
  }
}

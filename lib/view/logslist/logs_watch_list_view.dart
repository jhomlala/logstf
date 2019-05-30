import 'package:flutter/material.dart';

class LogsWatchListView extends StatefulWidget {
  @override
  _LogsWatchListViewState createState() => _LogsWatchListViewState();
}

class _LogsWatchListViewState extends State<LogsWatchListView> with AutomaticKeepAliveClientMixin<LogsWatchListView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(child: Text("Test"),);
  }

  @override
  bool get wantKeepAlive => true;
}

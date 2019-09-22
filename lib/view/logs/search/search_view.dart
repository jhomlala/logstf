import 'package:flutter/material.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/view/logs/search/player_search_view.dart';

import 'logs_search_view.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            title: Text("Search"),
            bottom: TabBar(
                controller: tabController,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(Icons.remove_red_eye),
                    text: applicationLocalization.getText("log_search_logs_search"),
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                    text: applicationLocalization.getText("log_search_players_search"),
                  ),
                ])),
        body: TabBarView(
            controller: tabController,
            children: [LogsSearchView(), PlayerSearchView()]));
  }
}

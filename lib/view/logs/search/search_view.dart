import 'package:flutter/material.dart';
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
                    text: "Logs search",
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                    text: "Players search",
                  ),
                ])),
        body: TabBarView(
            controller: tabController,
            children: [LogsSearchView(), PlayerSearchView()]));
  }
}

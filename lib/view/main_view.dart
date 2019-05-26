import 'package:flutter/material.dart';

import 'logslist/logs_list_view.dart';
import 'logslist/logs_search_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            title: Text("Logs TF"),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LogsSearchView()));
                  })
            ],
            bottom: TabBar(
                controller: tabController,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: "All",
                    icon: Icon(Icons.people),
                  ),
                  Tab(
                    text: "Favourites",
                    icon: Icon(Icons.favorite),
                  ),
                  Tab(
                    text: "Saved",
                    icon: Icon(Icons.save),
                  )
                ])),
        body: TabBarView(
            controller: tabController,
            children: [LogsListView(), Container(), Container()]));
  }
}

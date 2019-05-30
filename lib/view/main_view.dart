import 'package:flutter/material.dart';
import 'package:logstf/model/menu_item.dart';
import 'package:logstf/view/settings/settings_view.dart';

import 'logs/logs_saved_list_view.dart';
import 'logslist/logs_list_view.dart';
import 'logslist/logs_search_view.dart';
import 'logslist/logs_watch_list_view.dart';

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
                  }),
              PopupMenuButton<MenuItem>(
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return _getMenuItems().map((MenuItem menuItem) {
                    return PopupMenuItem<MenuItem>(
                      value: menuItem,
                      child: Text(menuItem.title),
                    );
                  }).toList();
                },
              ),
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
                    text: "Watchlist",
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  Tab(
                    text: "Saved",
                    icon: Icon(Icons.favorite),
                  )
                ])),
        body: TabBarView(
            controller: tabController,
            children: [LogsListView(), LogsWatchListView(), LogsSavedListView()]));
  }

  List<MenuItem> _getMenuItems() {
    List<MenuItem> menuItems = List();
    menuItems.add(MenuItem(title: "Settings", icon: Icons.settings));
    menuItems.add(MenuItem(title: "About", icon: Icons.settings));
    return menuItems;
  }

  void _select(MenuItem menuItem) {
    if (menuItem.title == "Settings") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsView()));
    }
  }
}

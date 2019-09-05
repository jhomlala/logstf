import 'package:flutter/material.dart';
import 'package:logstf/model/menu_item.dart';
import 'package:logstf/view/settings/settings_view.dart';
import 'about/about_view.dart';
import 'logs/logs_saved_list_view.dart';
import 'package:logstf/view/logs/logs_list_view.dart';
import 'package:logstf/view/logs/logs_watch_list_view.dart';

import 'logs/search/search_view.dart';

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
          key: Key("mainViewAppBar"),
            elevation: 0.0,
            title: Text("Pocket Logs"),
            actions: [
              IconButton(
                key: Key("mainViewSearchIcon"),
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchView()));
                  }),
              PopupMenuButton<MenuItem>(
                key: Key("mainViewOverflowMenu"),
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
                key: Key("mainViewTabBar"),
                controller: tabController,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: "All matches",
                    icon: Icon(Icons.flash_on),
                  ),
                  Tab(
                    text: "Saved players",
                    icon: Icon(Icons.people),
                  ),
                  Tab(
                    text: "Saved matches",
                    icon: Icon(Icons.favorite),
                  )
                ])),
        body: TabBarView(controller: tabController, children: [
          LogsListView(),
          LogsWatchListView(),
          LogsSavedListView()
        ]));
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
    if (menuItem.title == "About") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AboutView()));
    }
  }
}

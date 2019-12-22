import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logstf/model/menu_item.dart';
import 'package:logstf/model/navigation_event.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/view/settings/settings_view.dart';
import 'about/about_view.dart';
import 'help/help_view.dart';
import 'log/log_view.dart';
import 'logs/logs_saved_list_view.dart';
import 'package:logstf/view/logs/logs_list_view.dart';
import 'package:logstf/view/logs/logs_watch_list_view.dart';

import 'logs/search/search_view.dart';

class MainView extends StatefulWidget {
  final LogsListView logsListView;

  const MainView(this.logsListView);

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
    callGetDeepLinkLogId();
  }

  void callGetDeepLinkLogId() async {
    var channel = const MethodChannel("com.jhomlala.logstf.link");
    var result = await channel.invokeMethod<String>("getIntent");
    if (result != null && result != "none") {
      try {
        int logId;
        int playerSteamId;
        if (result.contains("#")) {
          var resultSplit = result.split("#");
          if (resultSplit.length == 2) {
            logId = int.parse(resultSplit[0]);
            playerSteamId = int.parse(resultSplit[1]);
          }
        } else {
          logId = int.parse(result);
        }

        if (logId != null) {
          Navigator.push<NavigationEvent>(
              context,
              MaterialPageRoute(
                  builder: (context) => LogView(
                        logId: logId,
                        selectePlayerSteamId: playerSteamId,
                      )));
        }
      } catch (exception) {
        print(exception);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchView()));
                  }),
              PopupMenuButton<MenuItem>(
                key: Key("mainViewOverflowMenu"),
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return _getMenuItems(context, applicationLocalization)
                      .map((MenuItem menuItem) {
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
                    text: applicationLocalization.getText("logs_all_matches"),
                    icon: Icon(Icons.flash_on),
                  ),
                  Tab(
                    text: applicationLocalization.getText("logs_saved_players"),
                    icon: Icon(Icons.people),
                  ),
                  Tab(
                    text: applicationLocalization.getText("logs_saved_matches"),
                    icon: Icon(Icons.favorite),
                  )
                ])),
        body: TabBarView(controller: tabController, children: [
          widget.logsListView,
          LogsWatchListView(),
          LogsSavedListView()
        ]));
  }

  List<MenuItem> _getMenuItems(
      BuildContext context, ApplicationLocalization applicationLocalization) {
    List<MenuItem> menuItems = List();
    menuItems.add(MenuItem(
        id: "menu_settings",
        title: applicationLocalization.getText("menu_settings"),
        icon: Icons.settings));
    menuItems.add(MenuItem(
        id: "menu_about",
        title: applicationLocalization.getText("menu_about"),
        icon: Icons.settings));
    menuItems.add(MenuItem(
        id: "menu_help",
        title: applicationLocalization.getText("menu_help"),
        icon: Icons.settings));
    return menuItems;
  }

  void _select(MenuItem menuItem) {
    if (menuItem.id == "menu_settings") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsView()));
    }
    if (menuItem.id == "menu_about") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AboutView()));
    }
    if (menuItem.id == "menu_help") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HelpView()));
    }
  }
}

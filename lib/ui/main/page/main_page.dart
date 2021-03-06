import 'package:fimber/fimber_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/model/internal/menu_item.dart';
import 'package:logstf/model/internal/search_player_matches_event.dart';
import 'package:logstf/repository/internal/app_state_manager.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/utils/app_const.dart';
import 'package:logstf/utils/application_localization.dart';
import 'package:logstf/utils/routing_helper.dart';
import 'package:logstf/ui/main/bloc/logs_list_fragment_bloc.dart';
import 'package:logstf/ui/main/bloc/logs_saved_logs_fragment_bloc.dart';
import 'package:logstf/ui/main/bloc/logs_saved_players_fragment_bloc.dart';
import 'package:sailor/sailor.dart';

import '../../common/base_page.dart';
import '../../common/base_page_state.dart';
import '../fragment/logs_saved_logs_fragment.dart';
import 'package:logstf/ui/main/fragment/logs_list_fragment.dart';
import 'package:logstf/ui/main/fragment/logs_saved_players_fragment.dart';

class MainPage extends BasePage {
  final Sailor sailor;
  final AppStateManager appStateManager;
  final LogsListFragmentBloc logsListFragmentBloc;
  final LogsSavedPlayersFragmentBloc logsSavedPlayersFragmentBloc;
  final LogsSavedLogsFragmentBloc logsSavedLogsFragmentBloc;

  const MainPage(this.sailor, this.appStateManager, this.logsListFragmentBloc,
      this.logsSavedPlayersFragmentBloc, this.logsSavedLogsFragmentBloc);

  @override
  _MainViewPage createState() => _MainViewPage();
}

class _MainViewPage extends BasePageState<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          await getNavigator().navigate(RoutingHelper.logPageRoute,
              params: {"logId": logId, "selectedPlayerSteamId": playerSteamId});
        }
      } catch (exception, stackTrace) {
        Fimber.e("Exception on callGetDeppLinkLogId",
            ex: exception, stacktrace: stackTrace);
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
                  onPressed: _onSearchClicked),
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
                controller: _tabController,
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
        body: TabBarView(controller: _tabController, children: [
          LogsListFragment(widget.logsListFragmentBloc, onLogClicked),
          LogsSavedPlayersFragment(
              widget.logsSavedPlayersFragmentBloc, onLogClicked),
          LogsSavedLogsFragment(widget.logsSavedLogsFragmentBloc, onLogClicked)
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
      getNavigator().navigate(RoutingHelper.settingsPageRoute);
    }
    if (menuItem.id == "menu_about") {
      getNavigator().navigate(RoutingHelper.aboutPageRoute);
    }
    if (menuItem.id == "menu_help") {
      getNavigator().navigate(RoutingHelper.helpPageRoute);
    }
  }

  void onLogClicked(int logId) async {
    SearchPlayerMatchesEvent searchPlayerMatchesNavigationEvent =
        await getNavigator().navigate(RoutingHelper.logPageRoute,
            params: {AppConst.logIdParameter: logId});
    if (searchPlayerMatchesNavigationEvent != null) {
      SearchData searchData = SearchData(
          player: searchPlayerMatchesNavigationEvent.steamId, clearData: true);
      widget.appStateManager.searchData = searchData;
      widget.logsListFragmentBloc.clearFilters();
      await widget.logsListFragmentBloc.searchLogsFromSearchData(searchData);
    }
  }

  void _onSearchClicked() async {
    SearchData searchData = await getNavigator()
        .navigate(RoutingHelper.searchPageRoute, params: {
      AppConst.searchDataParameter: widget.appStateManager.searchData
    });
    if (searchData != null) {
      widget.appStateManager.searchData = searchData;
      widget.logsListFragmentBloc.clearFilters();
      await widget.logsListFragmentBloc.searchLogsFromSearchData(searchData);
    }
  }
}

class MainPageProvider extends PageProvider<MainPage> {
  final Sailor sailor;
  final AppStateManager appStateManager;
  final LogsListFragmentBloc logsListFragmentBloc;
  final LogsSavedPlayersFragmentBloc logsSavedPlayersFragmentBloc;
  final LogsSavedLogsFragmentBloc logsSavedLogsFragmentBloc;

  MainPageProvider(this.sailor, this.appStateManager, this.logsListFragmentBloc,
      this.logsSavedPlayersFragmentBloc, this.logsSavedLogsFragmentBloc);

  @override
  MainPage create() {
    return MainPage(sailor, appStateManager, logsListFragmentBloc,
        logsSavedPlayersFragmentBloc, logsSavedLogsFragmentBloc);
  }
}

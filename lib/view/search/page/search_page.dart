import 'package:flutter/material.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/util/routing_helper.dart';
import 'package:logstf/view/main/bloc/main_page_bloc.dart';
import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/view/common/base_page.dart';
import 'package:logstf/view/common/base_page_state.dart';
import 'package:logstf/view/common/page_provider.dart';
import 'package:logstf/view/search/widget/player_search_view.dart';
import 'package:logstf/view/search/bloc/search_page_bloc.dart';
import 'package:sailor/sailor.dart';

import '../widget/logs_search_view.dart';

class SearchPage extends BasePage {
  final SearchPageBloc searchPageBloc;

  SearchPage(Sailor sailor, this.searchPageBloc) : super(sailor: sailor);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends BasePageState<SearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  SearchPageBloc get searchPageBloc => widget.searchPageBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initCompleted) {
      SearchData _initialSearchData =
          Sailor.param(context, AppConst.searchDataParameter);
      searchPageBloc.setSearchData(_initialSearchData);
      initCompleted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                title: Text("Search"),
                bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.remove_red_eye),
                        text: applicationLocalization
                            .getText("log_search_logs_search"),
                      ),
                      Tab(
                        icon: Icon(Icons.people),
                        text: applicationLocalization
                            .getText("log_search_players_search"),
                      ),
                    ])),
            body: TabBarView(controller: _tabController, children: [
              LogsSearchView(searchPageBloc, _onLogsSearchAction),
              PlayerSearchView(_onPlayerSearchAction)
            ])));
  }

  void _onLogsSearchAction(SearchData searchData) {
    getNavigator().pop(searchData);
  }

  void _onPlayerSearchAction(String playerName) async {
    SearchData searchData = await getNavigator().navigate(
        RoutingHelper.playerSearchResultsRoute,
        params: {AppConst.playerNameParameter: playerName});
    if (searchData != null){
      getNavigator().pop(searchData);
    }
  }

  Future<bool> _onWillPop() async {
    getNavigator().pop();
    return false;
  }
}

class SearchPageProvider extends PageProvider<SearchPage> {
  final Sailor sailor;
  final SearchPageBloc searchPageBloc;

  SearchPageProvider(this.sailor, this.searchPageBloc);

  @override
  SearchPage create() {
    return SearchPage(sailor, searchPageBloc);
  }
}

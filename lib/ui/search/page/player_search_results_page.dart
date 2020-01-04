import 'package:flutter/material.dart';
import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/model/player_search_result.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:logstf/ui/common/base_page_state.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/ui/search/bloc/player_search_results_page_bloc.dart';
import 'package:logstf/ui/common/widget/empty_card.dart';
import 'package:logstf/ui/common/widget/player_search_row_widget.dart';
import 'package:logstf/ui/common/widget/progress_bar.dart';
import 'package:sailor/sailor.dart';

class PlayerSearchResultsPage extends BasePage {
  final PlayerSearchResultsPageBloc playerSearchResultsPageBloc;

  const PlayerSearchResultsPage(Sailor sailor, this.playerSearchResultsPageBloc)
      : super(sailor: sailor);

  @override
  _PlayerSearchResultsPageState createState() =>
      _PlayerSearchResultsPageState();
}

class _PlayerSearchResultsPageState
    extends BasePageState<PlayerSearchResultsPage> {
  PlayerSearchResultsPageBloc get playerSearchResultsPageBloc =>
      widget.playerSearchResultsPageBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initCompleted) {
      String playerName = Sailor.param(context, AppConst.playerNameParameter);
      playerSearchResultsPageBloc.playerName = playerName;
      initCompleted = true;
      initOnDependenciesProvided();
    }
  }

  @override
  void initOnDependenciesProvided() {
    super.initOnDependenciesProvided();
    playerSearchResultsPageBloc.searchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            title: Text("Search: ${playerSearchResultsPageBloc.playerName}")),
        body: Container(
            color: Theme.of(context).primaryColor,
            child: StreamBuilder<List<PlayerSearchResult>>(
              stream: playerSearchResultsPageBloc.playersSearchSubject,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none ||
                    playerSearchResultsPageBloc.loading) {
                  return ProgressBar();
                } else {
                  var items =
                      playerSearchResultsPageBloc.playersSearchSubject.value;
                  if (items != null && items.length > 0) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, position) {
                        PlayerSearchResult playerSearchResult = items[position];
                        return PlayerSearchRowWidget(
                            playerSearchResult,
                            _onObservePlayerClicked,
                            _onSearchLogsClicked,
                            playerSearchResultsPageBloc
                                .isPlayerObserved(playerSearchResult));
                      },
                    );
                  } else {
                    return EmptyCard(description: "No players found");
                  }
                }
              },
            )));
  }

  void _onObservePlayerClicked(PlayerSearchResult playerSearchResult) {
    playerSearchResultsPageBloc.observePlayer(playerSearchResult);
  }

  void _onSearchLogsClicked(PlayerSearchResult playerSearchResult) {
    getNavigator().pop(SearchData(player: playerSearchResult.steamId));
  }
}

class PlayerSearchResultsPageProvider
    extends PageProvider<PlayerSearchResultsPage> {
  final Sailor sailor;
  final PlayerSearchResultsPageBloc playerSearchResultsPageBloc;

  PlayerSearchResultsPageProvider(
      this.sailor, this.playerSearchResultsPageBloc);

  @override
  PlayerSearchResultsPage create() {
    return PlayerSearchResultsPage(sailor, playerSearchResultsPageBloc);
  }
}

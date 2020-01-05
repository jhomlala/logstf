import 'package:inject/inject.dart';
import 'package:logstf/ui/about/page/about_page.dart';
import 'package:logstf/ui/help/page/help_page.dart';
import 'package:logstf/ui/log/bloc/log_details_bloc.dart';
import 'package:logstf/repository/internal/app_state_manager.dart';
import 'package:logstf/ui/main/bloc/logs_list_fragment_bloc.dart';
import 'package:logstf/ui/main/bloc/logs_saved_logs_fragment_bloc.dart';
import 'package:logstf/ui/main/bloc/logs_saved_players_fragment_bloc.dart';
import 'package:logstf/ui/log/page/log_page.dart';
import 'package:logstf/ui/player/bloc/log_player_player_fragment_bloc.dart';
import 'package:logstf/ui/player/page/log_player_page.dart';
import 'package:logstf/ui/search/bloc/player_search_results_page_bloc.dart';
import 'package:logstf/ui/search/page/player_search_results_page.dart';
import 'package:logstf/ui/search/page/search_page.dart';
import 'package:logstf/ui/main/page/main_page.dart';
import 'package:logstf/ui/search/bloc/search_page_bloc.dart';
import 'package:logstf/ui/settings/bloc/settings_bloc.dart';
import 'package:logstf/ui/settings/page/settings_page.dart';
import 'package:sailor/sailor.dart';

@module
class PageModule {
  @provide
  MainPageProvider provideMainPageProvider(
      Sailor sailor,
      AppStateManager appStateManager,
      LogsListFragmentBlocProvider logsListFragmentBlocProvider,
      LogsSavedPlayersFragmentBlocProvider logsSavedPlayersFragmentBlocProvider,
      LogsSavedLogsFragmentBlocProvider logsSavedLogsFragmentBlocProvider) {
    return MainPageProvider(
        sailor,
        appStateManager,
        logsListFragmentBlocProvider.create(),
        logsSavedPlayersFragmentBlocProvider.create(),
        logsSavedLogsFragmentBlocProvider.create());
  }

  @provide
  LogDetailsPageProvider provideLogDetailsPageProvider(
      Sailor sailor, LogDetailsBlocProvider logDetailsBlocProvider) {
    return LogDetailsPageProvider(sailor, logDetailsBlocProvider);
  }

  @provide
  SearchPageProvider provideSearchPageProvider(
      Sailor sailor, SearchPageBlocProvider searchPageBlocProvider) {
    return SearchPageProvider(sailor, searchPageBlocProvider.create());
  }

  @provide
  PlayerSearchResultsPageProvider providePlayerSearchResultsPageProvider(
      Sailor sailor,
      PlayerSearchResultsPageBlocProvider playerSearchResultsPageBlocProvider) {
    return PlayerSearchResultsPageProvider(
        sailor, playerSearchResultsPageBlocProvider.create());
  }

  @provide
  LogPlayerPageProvider provideLogPlayerPageProvider(Sailor sailor,
      LogPlayerPlayerFragmentBlocProvider logPlayerPlayerFragmentBlocProvider) {
    return LogPlayerPageProvider(
        sailor, logPlayerPlayerFragmentBlocProvider.create());
  }

  @provide
  SettingsPageProvider provideSettingsPageProvider(
      Sailor sailor, SettingsBlocProvider settingsBlocProvider) {
    return SettingsPageProvider(sailor, settingsBlocProvider.create());
  }

  @provide
  HelpPageProvider provideHelpPageProvider() {
    return HelpPageProvider();
  }

  @provide
  AboutPageProvider provideAboutPageProvider() {
    return AboutPageProvider();
  }
}

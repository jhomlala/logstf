import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/bloc/logs_player_observed_bloc.dart';
import 'package:logstf/bloc/players_observed_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/view/main/widget/logs_saved_players_fragment.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';
import 'test_helper.dart';

main() {
  testPlayersStreamBuilderEmpty();
  testPlayersFilledStreamBuilder();
  testPlayerLogsLoadingStreamBuilder();
  testPlayerLogsStreamBuilder();
  testPlayerLogsErrorStreamBuilder();
  testPlayerLogsEmptyStreamBuilder();
}

void testPlayersStreamBuilderEmpty() async {
  testWidgets("Stream builder with players empty test",
      (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsWatchListView());
    playersObservedBloc.loading = false;
    playersObservedBloc.playersObservedSubject.value = List();
    await pauseTester(tester);
    expectOneWidgetWithText(
        "No players observed. Please add player by clicking Observe player in player details.");
  });
}

void testPlayersFilledStreamBuilder() async {
  testWidgets("Stream builder with players filled test",
      (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsWatchListView());
    PlayerObserved player = setupMockPlayerObserved();
    List<PlayerObserved> players = List();
    players.add(player);
    playersObservedBloc.loading = false;
    playersObservedBloc.playersObservedSubject.value = players;
    await pauseTester(tester);
    expectOneWidgetByKey("logsWatchListViewDropdown");
    expectOneWidgetByKey("logsWatchListViewDeleteIconButton");
    expectOneWidgetWithText("Player:");
  });
}

void testPlayerLogsLoadingStreamBuilder() {
  testWidgets("Stream builder with player logs loading test",
      (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsWatchListView());
    PlayerObserved player = setupMockPlayerObserved();
    List<PlayerObserved> players = List();
    players.add(player);
    playersObservedBloc.loading = false;
    playersObservedBloc.playersObservedSubject.value = players;
    await pauseTester(tester);
    logsPlayerObservedBloc.loading = true;
    logsPlayerObservedBloc.logsSearchSubject.value = List();
    await pauseTester(tester);
    expectOneWidgetByType(ProgressBar);
  });
}

void testPlayerLogsStreamBuilder() {
  testWidgets("Stream builder with player logs filled test",
      (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsWatchListView());
    PlayerObserved player = setupMockPlayerObserved();
    List<PlayerObserved> players = List();
    players.add(player);
    playersObservedBloc.loading = false;
    playersObservedBloc.playersObservedSubject.value = players;
    await pauseTester(tester);
    List<LogShort> logs = List();
    logs.add(setupMockupLogShort());
    logs.add(setupMockupLogShort());
    logs.add(setupMockupLogShort());
    logsPlayerObservedBloc.loading = false;
    logsPlayerObservedBloc.logsSearchSubject.value = logs;
    await pauseTester(tester);
    expectNWidgetsByType(3, LogShortCard);
  });
}

void testPlayerLogsErrorStreamBuilder() {
  testWidgets("Stream builder with player logs error test",
      (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsWatchListView());
    PlayerObserved player = setupMockPlayerObserved();
    List<PlayerObserved> players = List();
    players.add(player);
    playersObservedBloc.loading = false;
    playersObservedBloc.playersObservedSubject.value = players;
    await pauseTester(tester);
    logsPlayerObservedBloc.logsSearchSubject.addError(Error());
    logsPlayerObservedBloc.loading = false;
    await pauseTester(tester);
    expectOneWidgetByType(EmptyCard);
  });
}

void testPlayerLogsEmptyStreamBuilder() {
  testWidgets("Stream builder with player logs empty test",
      (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsWatchListView());
    PlayerObserved player = setupMockPlayerObserved();
    List<PlayerObserved> players = List();
    players.add(player);
    playersObservedBloc.loading = false;
    playersObservedBloc.playersObservedSubject.value = players;
    await pauseTester(tester);
    logsPlayerObservedBloc.logsSearchSubject.add(List());
    logsPlayerObservedBloc.loading = false;
    await pauseTester(tester);
    expectOneWidgetByType(EmptyCard);
    expectOneWidgetWithText("There's no data.");
  });
}

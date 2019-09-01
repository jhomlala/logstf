import 'package:expandable/expandable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/view/logs/logs_list_view.dart';
import 'package:logstf/widget/empty_card.dart';
import 'package:logstf/widget/filters_card.dart';
import 'package:logstf/widget/log_short_card.dart';
import 'package:logstf/widget/progress_bar.dart';

import 'test_helper.dart';

main() {
  testStreamBuilder();
  testFiltersCard();
}

void testStreamBuilder() {
  testWidgets("Stream Builder Tests", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsListView());
    expectOneWidgetByType(ProgressBar);

    logsSearchBloc.logsSearchSubject.addError(Error());
    await pauseTester(tester);

    expectOneWidgetByType(EmptyCard);

    var list = List<LogShort>();
    list.add(setupMockupLogShort());
    list.add(setupMockupLogShort());
    list.add(setupMockupLogShort());
    logsSearchBloc.logsSearchSubject.value = list;
    await pauseTester(tester);
    expectNWidgetsByType(3, LogShortCard);


    logsSearchBloc.loading = false;
    logsSearchBloc.logsSearchSubject.value = List();
    await pauseTester(tester);
    expectZeroWidgetByType(LogShortCard);
    expectOneWidgetByType(EmptyCard);
    expectOneWidgetWithText("There's no logs found.");
  });
}

void testFiltersCard() {
  testWidgets("Filters card test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsListView());
    logsSearchBloc.searchLogs(
        map: "test", player: "test", title: "test", uploader: "test");
    await pauseTester(tester);
    expectOneWidgetByType(ExpandablePanel);
    expectOneWidgetByType(FiltersCard);
    await expectOneWidgetWithText("Active Filters");

    logsSearchBloc.clearFilters();
    await pauseTester(tester);
    expectZeroWidgetByType(ExpandablePanel);
    expectZeroWidgetByType(FiltersCard);
  });
}

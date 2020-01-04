import 'package:expandable/expandable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/ui/main/bloc/main_page_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/ui/main/widget/logs_list_fragment.dart';
import 'package:logstf/ui/common/widget/empty_card.dart';
import 'package:logstf/ui/main/widget/filters_card.dart';
import 'package:logstf/ui/main/widget/log_short_card.dart';
import 'package:logstf/ui/common/widget/progress_bar.dart';

import 'test_helper.dart';

main() {
  testStreamBuilderProgressBar();
  testStreamBuilderError();
  testStreamBuilderFilled();
  testStreamBuilderEmpty();
  testFiltersCard();
}

void testStreamBuilderProgressBar() async {
  testWidgets("Stream builder progress bar test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsListFragment());
    expectOneWidgetByType(ProgressBar);
  });
}

void testStreamBuilderError() async {
  testWidgets("Stream builder empty test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsListFragment());
    logsSearchBloc.logsSearchSubject.addError(Error());
    await pauseTester(tester);
    expectOneWidgetByType(EmptyCard);
  });
}

void testStreamBuilderFilled() async {
  testWidgets("Stream builder filled test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsListFragment());
    var list = List<LogShort>();
    list.add(setupMockupLogShort());
    list.add(setupMockupLogShort());
    list.add(setupMockupLogShort());
    logsSearchBloc.logsSearchSubject.value = list;
    await pauseTester(tester);
    expectNWidgetsByType(3, LogShortCard);
  });
}

void testStreamBuilderEmpty() async {
  testWidgets("Stream builder empty test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsListFragment());
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
    await setupWidgetWithScaffold(tester, LogsListFragment());
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

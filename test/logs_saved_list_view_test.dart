import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/bloc/logs_saved_bloc.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/ui/main/widget/logs_saved_logs_fragment.dart';
import 'package:logstf/ui/common/widget/empty_card.dart';
import 'package:logstf/ui/common/widget/log_short_card.dart';
import 'package:logstf/ui/common/widget/progress_bar.dart';

import 'test_helper.dart';

main() {
  testStreamBuilderProgressBar();
  testStreamBuilderEmpty();
  testStreamBuilderFilled();
}

void testStreamBuilderProgressBar() async {
  testWidgets("Stream builder progress bar test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsSavedLogsFragment());
    logsSavedBloc.loading = true;
    logsSavedBloc.savedLogsSubject.value = List();
    await pauseTester(tester);
    expectOneWidgetByType(ProgressBar);
  });
}

void testStreamBuilderEmpty() async {
  testWidgets("Stream builder empty test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsSavedLogsFragment());
    logsSavedBloc.loading = false;
    logsSavedBloc.savedLogsSubject.value = List();
    await pauseTester(tester);
    expectZeroWidgetByType(LogShortCard);
    expectOneWidgetByType(EmptyCard);
    expectOneWidgetWithText("There's no saved data.");
  });
}


void testStreamBuilderFilled() async {
  testWidgets("Stream builder filled test", (WidgetTester tester) async {
    await setupWidgetWithScaffold(tester, LogsSavedLogsFragment());
    var list = List<LogShort>();
    list.add(setupMockupLogShort());
    list.add(setupMockupLogShort());
    list.add(setupMockupLogShort());
    logsSavedBloc.savedLogsSubject.value = list;
    await pauseTester(tester);
    expectNWidgetsByType(3, LogShortCard);
  });
}
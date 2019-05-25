import 'package:flutter/material.dart';
import 'package:logstf/view/log_view.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:logstf/view/logslist/logs_list_view.dart';

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask() async {
  print('[BackgroundFetch] Headless event received.');
  BackgroundFetch.finish();
}

void main() {
  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.


  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }


}

class _MyAppState extends State<MyApp> {

  List<DateTime> _events = [];
  int _status = 0;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true
    ), () async {
      // This is the fetch-event callback.
      print('[BackgroundFetch] Event received');
      setState(() {
        _events.insert(0, new DateTime.now());
      });
      // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish();
    }).then((int status) {
      print('[BackgroundFetch] SUCCESS: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.deepPurple),
        home: LogsListView());
  }
}
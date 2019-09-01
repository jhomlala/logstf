import 'package:flutter/material.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/widget/logs_button.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutViewState();
  }
}

class _AboutViewState extends State<AboutView> {
  PackageInfo _packageInfo;

  @override
  initState() {
    getVersion();
    super.initState();
  }

  getVersion() async {
    _packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("About"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Theme.of(context).primaryColor,
        child: Column(children: [
          Card(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Column(mainAxisSize: MainAxisSize.min, children: _getWidgets())
              ]))
        ]),
      ),
    );
  }

  List<Widget> _getWidgets() {
    List<Widget> widgets = List();
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 20),
      ),
    );
    widgets.add(
      Text(
        "Pocket Logs",
        style: TextStyle(fontSize: 40),
      ),
    );
    if (_packageInfo != null) {
      widgets.add(Text(
        "${_packageInfo.version} (build ${_packageInfo.buildNumber})",
        style: TextStyle(fontSize: 25),
      ));
    }
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 30),
      ),
    );
    widgets.add(ClipOval(
      child: Image.network(
        AppConst.authorAvatarUrl,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
    ));
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
    );
    widgets.add(
      Text(
        "Jakub Homlala",
        style: TextStyle(fontSize: 20),
      ),
    );
    widgets.add(Row(children: [
      LogsButton(
        text: "GitHub",
        backgroundColor: Colors.grey,
        onPressed: () {
          _launchWebPage(AppConst.authorGithubUrl);
        },
      ),
      Padding(padding: EdgeInsets.only(left:10),),
      LogsButton(
        text: "Steam",
        backgroundColor: Colors.grey,
        onPressed: () {
          _launchWebPage(
              AppConst.authorSteamProfileUrl);
        },
      )
    ]));

    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 20),
      ),
    );
    widgets.add(
      Container(
          width: 300,
          child: Text(
            "If you encountered any problem, please report it in project page.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          )),
    );

    widgets.add(LogsButton(
        text: "Project page",
        backgroundColor: Colors.grey,
        onPressed: () {
          _launchWebPage(AppConst.projectGithubUrl);
        }));
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
    );

    return widgets;
  }

  _launchWebPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/widget/logs_button.dart';
import 'package:package_info/package_info.dart';

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
    widgets.add(Row(children: [_getOliWidget(),_getSupraWidget()],));



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
          AppUtils.launchWebPage(AppConst.projectGithubUrl);
        }));
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
    );

    return widgets;
  }

  Widget _getOliWidget(){
    List<Widget> widgets = List();
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
    widgets.add(
      Text(
        "Developer",
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
    );
    widgets.add(Column(children: [
      LogsButton(
        text: "GitHub",
        backgroundColor: Colors.grey,
        onPressed: () {
          AppUtils.launchWebPage(AppConst.authorGithubUrl);
        },
      ),
      Padding(
        padding: EdgeInsets.only(left: 5),
      ),
      LogsButton(
        text: "Steam",
        backgroundColor: Colors.grey,
        onPressed: () {
          AppUtils.launchWebPage(AppConst.authorSteamProfileUrl);
        },
      )
    ]));
    return Column(children: widgets,);
  }

  Widget _getSupraWidget(){
    List<Widget> widgets = List();
    widgets.add(ClipOval(
      child: Image.network(
        "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d0/d0e9e61aa2bc3ec6e3b6d5bd11de422c5d1870e9_full.jpg",
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
        "Supra",
        style: TextStyle(fontSize: 20),
      ),
    );
    widgets.add(
      Text(
        "Ideas",
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
    );
    widgets.add(Column(children: [
      LogsButton(
        text: "Page",
        backgroundColor: Colors.grey,
        onPressed: () {
          AppUtils.launchWebPage("https://supra.tf/");
        },
      ),
      Padding(
        padding: EdgeInsets.only(left: 5),
      ),
      LogsButton(
        text: "Steam",
        backgroundColor: Colors.grey,
        onPressed: () {
          AppUtils.launchWebPage("https://steamcommunity.com/id/cosiepatrzysz");
        },
      )
    ]));
    return Container(margin: EdgeInsets.only(left:5),child:Column(children: widgets));
  }
}

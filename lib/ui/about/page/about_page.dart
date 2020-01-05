import 'package:flutter/material.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:logstf/ui/common/base_page_state.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/utils/app_const.dart';
import 'package:logstf/utils/app_utils.dart';
import 'package:logstf/utils/application_localization.dart';
import 'package:logstf/ui/common/widget/logs_button.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends BasePageState<AboutPage> {
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
        child: ListView(children: [
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
    var applicationLocalization = ApplicationLocalization.of(context);
    double width = MediaQuery.of(context).size.width;
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
    widgets.add(Row(
      children: [_getOliWidget(), _getSupraWidget()],
    ));

    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 20),
      ),
    );
    widgets.add(
      Container(
          width: 300,
          child: Text(
            applicationLocalization.getText("about_problems"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          )),
    );

    widgets.add(LogsButton(
        text: applicationLocalization.getText("about_project_page"),
        backgroundColor: Colors.grey,
        onPressed: () {
          AppUtils.launchWebPage(AppConst.projectGithubUrl);
        }));
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
    );

    widgets.add(
      Container(
          width: 300,
          child: Text(
            applicationLocalization.getText("about_donate"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          )),
    );
    widgets.add(LogsButton(
      text: applicationLocalization.getText("about_send_trade"),
      backgroundColor: Colors.grey,
      onPressed: () {
        AppUtils.launchWebPage(AppConst.authorDonateUrl);
      },
    ));

    widgets.add(Divider(
      color: AppUtils.getBorderColor(context),
    ));
    widgets.add(Container(
        width: width * 0.9,
        child: Text(
          applicationLocalization.getText("about_team_fortress_privacy"),
          textAlign: TextAlign.center,
          maxLines: 5,
        )));

    widgets.add(Padding(
      padding: EdgeInsets.only(top: 20),
    ));

    return widgets;
  }

  Widget _getOliWidget() {
    List<Widget> widgets = List();
    var applicationLocalization = ApplicationLocalization.of(context);
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
        "Oli",
        style: TextStyle(fontSize: 20),
      ),
    );
    widgets.add(
      Text(
        applicationLocalization.getText("about_developer"),
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
    return Column(
      children: widgets,
    );
  }

  Widget _getSupraWidget() {
    List<Widget> widgets = List();
    var applicationLocalization = ApplicationLocalization.of(context);
    widgets.add(ClipOval(
      child: Image.network(
        AppConst.supraAvatarUrl,
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
        "supra",
        style: TextStyle(fontSize: 20),
      ),
    );
    widgets.add(
      Text(
        applicationLocalization.getText("about_ideas_tests"),
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
    );
    widgets.add(Column(children: [
      LogsButton(
        text: "Page",
        backgroundColor: Colors.grey,
        onPressed: () {
          AppUtils.launchWebPage(AppConst.supraWebPage);
        },
      ),
      Padding(
        padding: EdgeInsets.only(left: 5),
      ),
      LogsButton(
        text: "Steam",
        backgroundColor: Colors.grey,
        onPressed: () {
          AppUtils.launchWebPage(AppConst.supraSteamProfileUrl);
        },
      ),
    ]));

    return Container(
        margin: EdgeInsets.only(left: 5), child: Column(children: widgets));
  }
}

class AboutPageProvider extends PageProvider<AboutPage>{
  @override
  AboutPage create() {
    return AboutPage();
  }

}

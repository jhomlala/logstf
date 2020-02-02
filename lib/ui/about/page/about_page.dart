import 'package:flutter/material.dart';
import 'package:logstf/ui/about/widget/app_version_widget.dart';
import 'package:logstf/ui/about/widget/author_widget.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:logstf/ui/common/base_page_state.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/utils/app_const.dart';
import 'package:logstf/utils/app_utils.dart';
import 'package:logstf/utils/application_localization.dart';
import 'package:logstf/ui/common/widget/logs_button.dart';

class AboutPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends BasePageState<AboutPage> {
  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(applicationLocalization.getText("menu_about")),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildMainColumn(width, applicationLocalization)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildMainColumn(
      double width, ApplicationLocalization applicationLocalization) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          AppConst.appName,
          style: TextStyle(fontSize: 40),
        ),
        AppVersionWidget(),
        SizedBox(height: 30),
        _buildAuthorsRowWidget(applicationLocalization),
        SizedBox(height: 20),
        Container(
            width: 300,
            child: Text(
              applicationLocalization.getText("about_problems"),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            )),
        LogsButton(
            text: applicationLocalization.getText("about_project_page"),
            backgroundColor: Colors.grey,
            onPressed: () {
              AppUtils.launchWebPage(AppConst.projectGithubUrl);
            }),
        SizedBox(
          height: 10,
        ),
        Container(
            width: 300,
            child: Text(
              applicationLocalization.getText("about_donate"),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            )),
        LogsButton(
          text: applicationLocalization.getText("about_send_trade"),
          backgroundColor: Colors.grey,
          onPressed: () {
            AppUtils.launchWebPage(AppConst.authorDonateUrl);
          },
        ),
        Divider(
          color: AppUtils.getBorderColor(context),
        ),
        _buildTrademarksWidget(width, applicationLocalization),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Row _buildAuthorsRowWidget(ApplicationLocalization applicationLocalization) {
    return Row(
      children: [
        AuthorWidget(
          AppConst.authorAvatarUrl,
          AppConst.authorName,
          AppConst.github,
          applicationLocalization.getText("about_developer"),
          () {
            AppUtils.launchWebPage(AppConst.authorGithubUrl);
          },
          () {
            AppUtils.launchWebPage(AppConst.steamProfileUrl);
          },
        ),
        AuthorWidget(
          AppConst.supraAvatarUrl,
          AppConst.supraName,
          applicationLocalization.getText("about_page"),
          applicationLocalization.getText("about_ideas_tests"),
          () {
            AppUtils.launchWebPage(AppConst.supraWebPage);
          },
          () {
            AppUtils.launchWebPage(AppConst.supraSteamProfileUrl);
          },
        ),
      ],
    );
  }

  Widget _buildTrademarksWidget(
      double width, ApplicationLocalization applicationLocalization) {
    return Container(
      width: width * 0.9,
      child: Text(
        applicationLocalization.getText("about_team_fortress_privacy"),
        textAlign: TextAlign.center,
        maxLines: 5,
      ),
    );
  }
}

class AboutPageProvider extends PageProvider<AboutPage> {
  @override
  AboutPage create() {
    return AboutPage();
  }
}

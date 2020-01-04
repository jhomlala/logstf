import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:logstf/ui/common/base_page_state.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/util/application_localization.dart';

class HelpPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return _HelpPageState();
  }
}

class _HelpPageState extends BasePageState<HelpPage> {
  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(applicationLocalization.getText("menu_help"))),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
              children: _getHelpWidgets(context, applicationLocalization))),
    );
  }

  List<Widget> _getHelpWidgets(
      BuildContext context, ApplicationLocalization applicationLocalization) {
    List<Widget> widgets = List();
    widgets.add(_getHelpQuestion(
        context,
        applicationLocalization.getText("help_mvp_title"),
        applicationLocalization.getText("help_mvp_description")));
    widgets.add(_getHelpQuestion(
        context,
        applicationLocalization.getText("help_bug_title"),
        applicationLocalization.getText("help_bug_description")));
    widgets.add(_getHelpQuestion(
        context,
        applicationLocalization.getText("help_help_title"),
        applicationLocalization.getText("help_help_description")));

    widgets.add(_getHelpQuestion(
        context,
        applicationLocalization.getText("help_free_title"),
        applicationLocalization.getText("help_free_description")));
    widgets.add(_getHelpQuestion(
        context,
        applicationLocalization.getText("help_purpose_title"),
        applicationLocalization.getText("help_purpose_description")));
    widgets.add(_getHelpQuestion(
        context,
        applicationLocalization.getText("help_data_title"),
        applicationLocalization.getText("help_data_description")));
    return widgets;
  }

  Widget _getHelpQuestion(
      BuildContext context, String title, String description) {
    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: ExpandablePanel(
            header: Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(title, style: TextStyle(fontSize: 20)))),
            expanded: Container(
                width: MediaQuery.of(context).size.width - 20,
                padding: EdgeInsets.all(10),
                child: Text(
                  description,
                  maxLines: 50,
                ))));
  }
}

class HelpPageProvider extends PageProvider<HelpPage> {
  @override
  HelpPage create() {
    return HelpPage();
  }
}

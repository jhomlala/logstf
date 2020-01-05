import 'package:flutter/material.dart';
import 'package:logstf/ui/common/base_page.dart';
import 'package:logstf/ui/common/base_page_state.dart';
import 'package:logstf/ui/common/page_provider.dart';
import 'package:logstf/ui/help/widget/help_question_widget.dart';
import 'package:logstf/utils/application_localization.dart';

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
      appBar: AppBar(
          elevation: 0.0,
          title: Text(applicationLocalization.getText("menu_help"))),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(children: [
            HelpQuestionWidget(
                applicationLocalization.getText("help_mvp_title"),
                applicationLocalization.getText("help_mvp_description")),
            HelpQuestionWidget(
                applicationLocalization.getText("help_bug_title"),
                applicationLocalization.getText("help_bug_description")),
            HelpQuestionWidget(
                applicationLocalization.getText("help_help_title"),
                applicationLocalization.getText("help_help_description")),
            HelpQuestionWidget(
                applicationLocalization.getText("help_free_title"),
                applicationLocalization.getText("help_free_description")),
            HelpQuestionWidget(
                applicationLocalization.getText("help_purpose_title"),
                applicationLocalization.getText("help_purpose_description")),
            HelpQuestionWidget(
                applicationLocalization.getText("help_data_title"),
                applicationLocalization.getText("help_data_description"))
          ])),
    );
  }
}

class HelpPageProvider extends PageProvider<HelpPage> {
  @override
  HelpPage create() {
    return HelpPage();
  }
}

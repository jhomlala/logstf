import 'package:flutter/material.dart';
import 'package:logstf/view/main/bloc/main_page_bloc.dart';
import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/view/search/bloc/search_page_bloc.dart';
import 'package:logstf/widget/logs_button.dart';

class LogsSearchView extends StatefulWidget {
  final SearchPageBloc searchPageBloc;
  final Function onSearchAction;

  const LogsSearchView(this.searchPageBloc, this.onSearchAction);

  @override
  _LogsSearchViewState createState() => _LogsSearchViewState();
}

class _LogsSearchViewState extends State<LogsSearchView> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final GlobalKey _mapKey = GlobalKey<FormFieldState>();
  final GlobalKey _uploaderKey = GlobalKey<FormFieldState>();
  final GlobalKey _titleKey = GlobalKey<FormFieldState>();
  final GlobalKey _playerKey = GlobalKey<FormFieldState>();
  final TextEditingController _mapController = TextEditingController();
  final TextEditingController _uploaderController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _playerController = TextEditingController();
  bool _editingControllersInitialized = false;

  @override
  void dispose() {
    _mapController.dispose();
    _uploaderController.dispose();
    _playerController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!_editingControllersInitialized) {
      SearchData searchData = widget.searchPageBloc.getSearchData();
      _initEditingControllers(searchData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme
          .of(context)
          .primaryColor,
      child: ListView(children: [
        Card(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: _getForm())
      ]),
    );
  }

  Form _getForm() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            padding: EdgeInsets.all(5),
            child: Column(children: _getFormWidget(context))));
  }

  List<Widget> _getFormWidget(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    List<Widget> formWidgets = new List();

    formWidgets.add(
      new TextFormField(
        key: _mapKey,
        controller: _mapController,
        decoration: InputDecoration(
            hintText: applicationLocalization.getText("log_search_map"),
            labelText: applicationLocalization.getText("log_search_map")),
      ),
    );

    formWidgets.add(
      new TextFormField(
        key: _uploaderKey,
        controller: _uploaderController,
        decoration: InputDecoration(
            hintText: applicationLocalization.getText("log_search_uploader"),
            labelText: applicationLocalization.getText("log_search_uploader")),
      ),
    );

    formWidgets.add(
      new TextFormField(
        key: _titleKey,
        controller: _titleController,
        decoration: InputDecoration(
            hintText: applicationLocalization.getText("log_search_title"),
            labelText: applicationLocalization.getText("log_search_title")),
      ),
    );

    formWidgets.add(
      new TextFormField(
        key: _playerKey,
        controller: _playerController,
        decoration: InputDecoration(
            hintText:
            applicationLocalization.getText("log_search_player_steam_id"),
            labelText:
            applicationLocalization.getText("log_search_player_steam_id")),
      ),
    );
    formWidgets.add(Padding(
      padding: EdgeInsets.only(top: 10),
    ));
    formWidgets
        .add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      LogsButton(
        text: applicationLocalization.getText("log_search_clear_filters"),
        onPressed: _onClearFiltersClicked,
        backgroundColor: Colors.grey,
      ),
      LogsButton(
        text: applicationLocalization.getText("log_search_search"),
        onPressed: _onSendClicked,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
    ]));

    return formWidgets;
  }

  void _onSendClicked() {
    var map = _mapController.text;
    var uploader = _uploaderController.text;
    var title = _titleController.text;
    var player = _playerController.text;

    widget.onSearchAction(SearchData(
        map: map,
        uploader: uploader,
        title: title,
        player: player,
        clearData: false));
  }

  void _onClearFiltersClicked() {
    widget.onSearchAction(SearchData(clearData: true));
  }

  void _initEditingControllers(SearchData searchData) {
    if (searchData != null) {
      _mapController.text = searchData.map;
      _uploaderController.text = searchData.uploader;
      _titleController.text = searchData.title;
      _playerController.text = searchData.player;
    }
  }
}

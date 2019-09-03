import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/widget/logs_button.dart';

class LogsSearchView extends StatefulWidget {
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
      _initEditingControllers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
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
            child: Column(children: _getFormWidget())));
  }

  List<Widget> _getFormWidget() {
    List<Widget> formWidgets = new List();

    formWidgets.add(
      new TextFormField(
        key: _mapKey,
        controller: _mapController,
        decoration: InputDecoration(hintText: 'Map', labelText: 'Map'),
      ),
    );

    formWidgets.add(
      new TextFormField(
        key: _uploaderKey,
        controller: _uploaderController,
        decoration:
            InputDecoration(hintText: 'Uploader', labelText: 'Uploader'),
      ),
    );

    formWidgets.add(
      new TextFormField(
        key: _titleKey,
        controller: _titleController,
        decoration: InputDecoration(hintText: 'Title', labelText: 'Title'),
      ),
    );

    formWidgets.add(
      new TextFormField(
        key: _playerKey,
        controller: _playerController,
        decoration: InputDecoration(hintText: 'Player steamId', labelText: 'Player steamId'),
      ),
    );
    formWidgets.add(Padding(
      padding: EdgeInsets.only(top: 10),
    ));
    formWidgets
        .add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      LogsButton(
        text: "Clear filters",
        onPressed: _onClearFiltersClicked,
        backgroundColor: Colors.grey,
      ),
      LogsButton(
        text: "Send",
        onPressed: _onSendClicked,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    ]));

    return formWidgets;
  }

  void _onSendClicked() {
    var map = _mapController.text;
    var uploader = _uploaderController.text;
    var title = _titleController.text;
    var player = _playerController.text;

    logsSearchBloc.clearLogs();
    logsSearchBloc.searchLogs(
        map: map, uploader: uploader, title: title, player: player);
    Navigator.pop(context);
  }

  void _onClearFiltersClicked() {
    logsSearchBloc.clearFilters();
    logsSearchBloc.searchLogs();
    Navigator.pop(context);
  }

  void _initEditingControllers() {
    _mapController.text = logsSearchBloc.map;
    _uploaderController.text = logsSearchBloc.uploader;
    _playerController.text = logsSearchBloc.player;
    _titleController.text = logsSearchBloc.title;
    _editingControllersInitialized = true;
  }
}

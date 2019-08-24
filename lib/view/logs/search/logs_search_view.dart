import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/widget/logs_button.dart';

class LogsSearchView extends StatefulWidget {
  @override
  _LogsSearchViewState createState() => _LogsSearchViewState();
}

class _LogsSearchViewState extends State<LogsSearchView> {
  final _formKey = GlobalKey<FormState>();
  var _mapKey = GlobalKey<FormFieldState>();
  var _uploaderKey = GlobalKey<FormFieldState>();
  var _titleKey = GlobalKey<FormFieldState>();
  var _playerKey = GlobalKey<FormFieldState>();
  final _mapController = TextEditingController();
  final _uploaderController = TextEditingController();
  final _titleController = TextEditingController();
  final _playerController = TextEditingController();
  var _editingControllersInitialized = false;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Search logs"),
      ),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(children: [
            Card(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: _getForm())
          ])),
    );
  }

  Form _getForm() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            padding: EdgeInsets.all(5),
            child: Column(children: getFormWidget())));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidgets = new List();

    formWidgets.add(
      new TextFormField(
          key: _mapKey,
          controller: _mapController,
          decoration: InputDecoration(hintText: 'Map', labelText: 'Map'),
          validator: (value) {}),
    );

    formWidgets.add(
      new TextFormField(
          key: _uploaderKey,
          controller: _uploaderController,
          decoration:
              InputDecoration(hintText: 'Uploader', labelText: 'Uploader'),
          validator: (value) {}),
    );

    formWidgets.add(
      new TextFormField(
          key: _titleKey,
          controller: _titleController,
          decoration: InputDecoration(hintText: 'Title', labelText: 'Title'),
          validator: (value) {}),
    );

    formWidgets.add(
      new TextFormField(
          key: _playerKey,
          controller: _playerController,
          decoration: InputDecoration(hintText: 'Player', labelText: 'Player'),
          validator: (value) {}),
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

  _onSendClicked() {
    var map = _mapController.text;
    var uploader = _uploaderController.text;
    var title = _titleController.text;
    var player = _playerController.text;

    print("Searching...");
    logsSearchBloc.clearLogs();
    logsSearchBloc.searchLogs(
        map: map, uploader: uploader, title: title, player: player);
    Navigator.pop(context);
  }

  _onClearFiltersClicked() {
    logsSearchBloc.clearFilters();
    Navigator.pop(context);
  }

  void _initEditingControllers() {
    print("Init editing controllers");
    _mapController.text = logsSearchBloc.map;
    _uploaderController.text = logsSearchBloc.uploader;
    _playerController.text = logsSearchBloc.player;
    _titleController.text = logsSearchBloc.title;
    _editingControllersInitialized = true;
  }
}

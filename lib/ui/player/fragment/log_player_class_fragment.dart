import 'package:flutter/material.dart';
import 'package:logstf/model/external/class_stats.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/ui/player/widget/demoman_overview_card.dart';
import 'package:logstf/ui/player/widget/engineer_overview_card.dart';
import 'package:logstf/ui/player/widget/pyro_overview_card.dart';
import 'package:logstf/ui/player/widget/soldier_overview_widget.dart';
import 'package:logstf/util/application_localization.dart';

import 'package:logstf/ui/player/widget/heavy_overview_card.dart';
import 'package:logstf/ui/player/widget/medic_overview_card.dart';

import 'package:logstf/ui/player/widget/scout_overview_card.dart';
import 'package:logstf/ui/player/widget/sniper_overview_card.dart';

import 'package:logstf/ui/player/widget/spy_overview_card.dart';

class LogPlayerClassOverviewFragment extends StatefulWidget {
  final Log log;
  final Player player;

  const LogPlayerClassOverviewFragment(this.log, this.player);

  @override
  _LogPlayerClassOverviewFragmentState createState() =>
      _LogPlayerClassOverviewFragmentState();
}

class _LogPlayerClassOverviewFragmentState
    extends State<LogPlayerClassOverviewFragment> {
  List<String> _classes;
  String _selectedClass;

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(children: [
        SingleChildScrollView(
            child: Card(
                child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${applicationLocalization.getText("log_class")}: ",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          _getClassesDropdown()
                        ])))),
        _getClassWidget()
      ]),
    );
  }

  Widget _getClassWidget() {
    if (_selectedClass == "scout") {
      return ScoutOverviewCard(widget.player, widget.log);
    }
    if (_selectedClass == "soldier") {
      return SoldierOverviewWidget(widget.player, widget.log);
    }
    if (_selectedClass == "pyro") {
      return PyroOverviewCard(widget.player, widget.log);
    }
    if (_selectedClass == "demoman") {
      return DemomanOverviewCard(widget.player, widget.log);
    }
    if (_selectedClass == "heavyweapons") {
      return HeavyOverviewCard(widget.player, widget.log);
    }
    if (_selectedClass == "engineer") {
      return EngineerOverviewCard(widget.player, widget.log);
    }
    if (_selectedClass == "medic") {
      return MedicOverviewCard(widget.player, widget.log);
    }
    if (_selectedClass == "sniper") {
      return SniperOverviewCard(widget.player, widget.log);
    }
    if (_selectedClass == "spy") {
      return SpyOverviewCard(widget.player, widget.log);
    }

    return Container();
  }

  @override
  void initState() {
    super.initState();
    _classes = _getPlayerClasses();
    _selectedClass = _classes[0];
  }

  Widget _getClassesDropdown() {
    return DropdownButton<String>(
        elevation: 2,
        isDense: true,
        iconSize: 20.0,
        value: _selectedClass,
        items: _classes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child:Text(_formatClassName(value),
                style: TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (value) {
          //_onClassSelected(value);
          setState(() {
            _selectedClass = value;
          });
        });
  }

  List<String> _getPlayerClasses() {
    return widget.player.classStats.map((ClassStats classStats) {
      return classStats.type;
    }).toList();
  }

  String _formatClassName(String rawClassName) {
    if (rawClassName == "heavyweapons") {
      return "Heavy";
    } else {
      return rawClassName.substring(0, 1).toUpperCase() +
          rawClassName.substring(1, rawClassName.length);
    }
  }
}

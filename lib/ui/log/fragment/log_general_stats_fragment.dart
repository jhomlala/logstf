import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/internal/match_type.dart';
import 'package:logstf/utils/app_utils.dart';
import 'package:logstf/utils/application_localization.dart';
import 'package:logstf/ui/log/widget/teams_score_table_widget.dart';

class LogGeneralStatsFragment extends StatefulWidget {
  final Log log;

  const LogGeneralStatsFragment(this.log);

  @override
  _LogGeneralStatsFragmentState createState() => _LogGeneralStatsFragmentState();
}

class _LogGeneralStatsFragmentState extends State<LogGeneralStatsFragment> {
  Log get _log => widget.log;

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
            child: Column(children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Card(
                  elevation: 10.0,
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    _getTitleWidget(context),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TeamsScoreTableWidget(
                      bluTeamScore: _log.teams.blue.score,
                      redTeamScore: _log.teams.red.score,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ]))),
          Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                      elevation: 10.0,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Table(
                            children:
                                _getTeamStatsTableRows(applicationLocalization),
                          ))))),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Card(
                  elevation: 10.0,
                  child: Column(
                    children: [
                      _getMapWidget(context, applicationLocalization),
                      _getMatchTypeWidget(context, applicationLocalization),
                      _getTimestampWidget(applicationLocalization),
                      _getTimeWidget(context, applicationLocalization),
                      _getUploaderWidget(applicationLocalization),
                      _getMatchIdWidget(applicationLocalization)
                    ],
                  ))),
        ])));
  }

  Widget _getTitleWidget(BuildContext context) {
    return Text(
      _log.info.title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.title,
    );
  }

  Widget _getMapWidget(
      BuildContext context, ApplicationLocalization applicationLocalization) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/map.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  ${applicationLocalization.getText("log_map")} "),
          Text(
            "${_log.info.map}",
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getTimeWidget(
      BuildContext context, ApplicationLocalization applicationLocalization) {
    var length = _log.length;
    var lengthHours = (length / 3600).floor();
    var lengthMinutes = ((length - lengthHours * 3600) / 60).floor();
    var lengthSeconds = length - lengthHours * 3600 - lengthMinutes * 60;

    var lengthText = "";
    if (lengthHours > 0) {
      lengthText += "$lengthHours h";
    }
    if (lengthMinutes > 0) {
      lengthText += " $lengthMinutes m";
    }
    if (lengthSeconds > 0) {
      lengthText += " $lengthSeconds s";
    }
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/timer.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  ${applicationLocalization.getText("log_played")}"),
          Text(
            lengthText,
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getTimestampWidget(ApplicationLocalization applicationLocalization) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(_log.info.date * 1000);
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/calendar.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  ${applicationLocalization.getText("log_played_at")} "),
          Text(
            DateFormat('yyyy-MM-dd kk:mm:ss').format(dateTime),
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getMatchTypeWidget(
      BuildContext context, ApplicationLocalization applicationLocalization) {
    MatchType matchType = LogHelper.getMatchType(
        _log.players.values.length, _log.info.map, context);
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/battle.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  ${applicationLocalization.getText("log_type")} "),
          Text(
            matchType.name,
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getUploaderWidget(ApplicationLocalization applicationLocalization) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/upload.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  ${applicationLocalization.getText("log_uploaded_by")} "),
          Flexible(
              child: Container(
            child: Text(
                "${_log.info.uploader.name} (${_log.info.uploader.info})",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18)),
          ))
        ]));
  }

  Widget _getMatchIdWidget(ApplicationLocalization applicationLocalization) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            Icons.important_devices,
            color: AppUtils.getIconColor(context),
            size: 20,
          ),
          Text("  ${applicationLocalization.getText("log_match_id")} "),
          Flexible(
              child: Container(
            child: Text("#${_log.id}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18)),
          ))
        ]));
  }

  List<TableRow> _getTeamStatsTableRows(
      ApplicationLocalization applicationLocalization) {
    List<TableRow> tableRows = List();
    tableRows.add(_getHeaderRow(applicationLocalization));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_kills"),
        "${LogHelper.getKillsSum(_log, "Red")}",
        "${LogHelper.getKillsSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_deaths"),
        "${LogHelper.getDeathsSum(_log, "Red")}",
        "${LogHelper.getDeathsSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_assists"),
        "${LogHelper.getAssistsSum(_log, "Red")}",
        "${LogHelper.getAssistsSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_damage"),
        "${LogHelper.getDamageSum(_log, "Red")}",
        "${LogHelper.getDamageSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_damage_taken"),
        "${LogHelper.getDamageTakenSum(_log, "Red")}",
        "${LogHelper.getDamageTakenSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_caps"),
        "${LogHelper.getCapSum(_log, "Red")}",
        "${LogHelper.getCapSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_charges"),
        "${LogHelper.getChargeSum(_log, "Red")}",
        "${LogHelper.getChargeSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_drops"),
        "${LogHelper.getDropSum(_log, "Red")}",
        "${LogHelper.getDropSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "KA/D",
        "${LogHelper.getTeamKAPD(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamKAPD(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "D/M",
        "${LogHelper.getTeamDamagePerMinute(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamDamagePerMinute(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "K/D",
        "${LogHelper.getTeamKillsPerDeaths(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamKillsPerDeaths(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "DT/M",
        "${LogHelper.getTeamDamageTakenPerMinute(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamDamageTakenPerMinute(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        applicationLocalization.getText("log_hp_pickups"),
        "${LogHelper.getMedkitsSum(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getMedkitsSum(_log, "Blue").toStringAsFixed(2)}"));

    tableRows.add(_getRow(
        applicationLocalization.getText("log_hp_from_pickups"),
        "${LogHelper.getMedkitsHPSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getMedkitsHPSum(_log, "Blue").toStringAsFixed(0)}"));

    tableRows.add(_getRow(
        applicationLocalization.getText("log_headshots"),
        "${LogHelper.getHeadshotsSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getHeadshotsSum(_log, "Blue").toStringAsFixed(0)}"));

    tableRows.add(_getRow(
        applicationLocalization.getText("log_sentries"),
        "${LogHelper.getSentriesSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getSentriesSum(_log, "Blue").toStringAsFixed(0)}"));

    tableRows.add(_getRow(
        applicationLocalization.getText("log_backstabs"),
        "${LogHelper.getBackstabsSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getBackstabsSum(_log, "Blue").toStringAsFixed(0)}"));
    return tableRows;
  }

  TableRow _getHeaderRow(ApplicationLocalization applicationLocalization) {
    return TableRow(children: [
      Container(
          color: Theme.of(context).primaryColor,
          child: Container(
              decoration: BoxDecoration(
                  color: AppUtils.darkBlueColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
              height: 30,
              child: Center(
                  child: Text(applicationLocalization.getText("log_metric"),
                      style: TextStyle(color: Colors.white, fontSize: 16))))),
      Container(
          decoration: BoxDecoration(color: Colors.red),
          height: 30,
          child: Center(
              child: Text("RED",
                  style: TextStyle(color: Colors.white, fontSize: 16)))),
      Container(
          color: Theme.of(context).primaryColor,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(8))),
              height: 30,
              child: Center(
                  child: Text("BLU",
                      style: TextStyle(color: Colors.white, fontSize: 16)))))
    ]);
  }

  TableRow _getRow(
      String metricName, String redTeamValue, String blueTeamValue) {
    return TableRow(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppUtils.getBorderColor(context)))),
        children: [
          Container(
              height: 20,
              child: Center(
                  child: Text(
                metricName,
                style: TextStyle(fontSize: 16),
              ))),
          Container(
              height: 20,
              child: Center(
                  child: Text(redTeamValue, style: TextStyle(fontSize: 16)))),
          Container(
              height: 20,
              child: Center(
                  child: Text(blueTeamValue, style: TextStyle(fontSize: 16))))
        ]);
  }
}

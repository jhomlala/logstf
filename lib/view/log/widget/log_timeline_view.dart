import 'package:flutter/material.dart';
import 'package:logstf/model/event.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class LogTimelineView extends StatefulWidget {
  final Log log;

  const LogTimelineView(this.log);
  @override
  State<StatefulWidget> createState() {
    return _LogTimelineViewState();
  }
}

class _LogTimelineViewState extends State<LogTimelineView> {
  Log get _log => widget.log;
  List<Event> _events;
  int _currentRoundStartTime;

  @override
  void initState() {
    _events = _getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Container(
            margin: EdgeInsets.all(5),
            child: _setupTimelineWidget(TimelinePosition.Left)));
  }

  _getEvents() {
    List<Event> events = List();
    int index = 1;
    _log.rounds.forEach((round) {
      events.add(Event(
        type: "round_start",
        time: round.startTime,
        team: "$index",
      ));
      events.addAll(round.events);
      index++;
    });
    return events;
  }

  Color _getTimelineColor() {
    Brightness brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light) {
      return Colors.white;
    } else {
      return AppUtils.greyColor;
    }
  }

  _setupTimelineWidget(TimelinePosition position) => Timeline.builder(
      itemBuilder: _setupTimelineElement,
      itemCount: _events.length,
      lineColor: _getTimelineColor(),
      physics: ClampingScrollPhysics());

  TimelineModel _setupTimelineElement(BuildContext context, int i) {
    Event event = _events[i];
    if (event.type == "round_start") {
      _currentRoundStartTime = event.time;
    }
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _getTime(event),
                  style: textTheme.caption,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                _getEventDescription(event),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == 10,
        iconBackground: _getTimelineColor(),
        icon: Icon(
          _getIcon(event),
          color: Theme.of(context).primaryColor,
        ));
  }

  String _getTime(Event event) {
    var applicationLocalization = ApplicationLocalization.of(context);
    if (event.type == "round_start") {
      return _formatTime(
          DateTime.fromMillisecondsSinceEpoch(event.time * 1000));
    } else {
      return _formatTime(DateTime.fromMillisecondsSinceEpoch(
              _currentRoundStartTime * 1000 + event.time * 1000)) +
          " ( +${event.time} ${applicationLocalization.getText("log_seconds")} )";
    }
  }

  String _formatTime(DateTime dateTime) {
    return "${_formatTimeUnit(dateTime.hour)}:${_formatTimeUnit(dateTime.minute)}:${_formatTimeUnit(dateTime.second)}";
  }

  String _formatTimeUnit(int unit) {
    if (unit < 10) {
      return "0$unit";
    } else {
      return "$unit";
    }
  }

  Color _getTeamColor(String team) {
    if (team == "Red") {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  Widget _getEventDescription(Event event) {
    List<TextSpan> children = List();
    var applicationLocalization = ApplicationLocalization.of(context);
    if (event.type == "round_start") {
      children.add(
          TextSpan(text: "${_getRoundNumberName(event.team)} ${applicationLocalization.getText("log_timeline_round_started")}"));
    }
    if (event.type == "pointcap") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_capped_point")}"));
    }
    if (event.type == "drop") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_medic_drop")}"));
    }
    if (event.type == "medic_death") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_medic_died")}"));
    }
    if (event.type == "charge") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_medic_charged")}"));
    }
    if (event.type == "round_win") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_won_round")}"));
    }
    if (event.type == "picked up") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_picked_intel")}"));
    }
    if (event.type == "captured") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: "  ${applicationLocalization.getText("log_timeline_captured_intel")}"));
    }
    if (event.type == "defended") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_defended_intel")}"));
    }
    if (event.type == "dropped") {
      children.add(TextSpan(
          text: _getTeamName(event.team),
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " ${applicationLocalization.getText("log_timeline_dropped_intel")}"));
    }

    return RichText(
        text: TextSpan(
            style: new TextStyle(
                fontSize: 12.0, color: Theme.of(context).textTheme.body1.color),
            children: children));
  }

  IconData _getIcon(Event event) {
    if (event.type == "round_start") {
      return Icons.timer;
    }
    if (event.type == "pointcap") {
      return Icons.add_location;
    }
    if (event.type == "drop") {
      return Icons.close;
    }
    if (event.type == "medic_death") {
      return Icons.arrow_downward;
    }
    if (event.type == "charge") {
      return Icons.flash_on;
    }
    if (event.type == "round_win") {
      return Icons.done;
    }
    if (event.type == "picked up") {
      return Icons.file_upload;
    }
    if (event.type == "captured") {
      return Icons.assistant_photo;
    }
    if (event.type == "defended") {
      return Icons.lock;
    }
    if (event.type == "dropped") {
      return Icons.pin_drop;
    }

    return Icons.remove_red_eye;
  }

  String _getTeamName(String teamName) {
    if (teamName == "Blue") {
      return "BLU";
    } else {
      return "RED";
    }
  }

  String _getRoundNumberName(String roundId) {
    var applicationLocalization = ApplicationLocalization.of(context);
    if (roundId == "1") {
      return applicationLocalization.getText("log_1st");
    }
    if (roundId == "2") {
      return applicationLocalization.getText("log_2nd");
    }
    if (roundId == "3") {
      return applicationLocalization.getText("log_3rd");
    }
    return applicationLocalization
        .getText("log_nth")
        .replaceAll("<n>", roundId);
  }
}

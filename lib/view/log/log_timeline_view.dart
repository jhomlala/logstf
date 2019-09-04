import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/model/event.dart';
import 'package:logstf/model/log.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class LogTimelineView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogTimelineViewState();
  }
}

class _LogTimelineViewState extends State<LogTimelineView> {
  Log _log;
  List<Event> _events;
  int _currentRoundStartTime;

  @override
  void initState() {
    _log = logDetailsBloc.logSubject.value;
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

  _setupTimelineWidget(TimelinePosition position) => Timeline.builder(
      itemBuilder: _setupTimelineElement,
      itemCount: _events.length,
      lineColor: Colors.white,
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
        iconBackground: Colors.white,
        icon: Icon(
          _getIcon(event),
          color: Theme.of(context).primaryColor,
        ));
  }

  String _getTime(Event event) {
    if (event.type == "round_start") {
      return _formatTime(
          DateTime.fromMillisecondsSinceEpoch(event.time * 1000));
    } else {
      return _formatTime(DateTime.fromMillisecondsSinceEpoch(
              _currentRoundStartTime * 1000 + event.time * 1000)) +
          " ( +${event.time} seconds )";
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

    if (event.type == "round_start") {
      children.add(
          TextSpan(text: "${_getRoundNumberName(event.team)} round started"));
    }
    if (event.type == "pointcap") {
      children.add(TextSpan(
          text: event.team,
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " has capped point"));
    }
    if (event.type == "drop") {
      children.add(TextSpan(
          text: event.team,
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " medic has died and dropped uber"));
    }
    if (event.type == "medic_death") {
      children.add(TextSpan(
          text: event.team,
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " medic has died"));
    }
    if (event.type == "charge") {
      children.add(TextSpan(
          text: event.team,
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " medic has charged uber"));
    }
    if (event.type == "round_win") {
      children.add(TextSpan(
          text: event.team,
          style: TextStyle(
              color: _getTeamColor(event.team), fontWeight: FontWeight.w600)));
      children.add(TextSpan(text: " has won round"));
    }
    return RichText(
        text: TextSpan(
            style: new TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
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

    return Icons.remove_red_eye;
  }

  String _getRoundNumberName(String roundId) {
    if (roundId == "1") {
      return "1st";
    }
    if (roundId == "2") {
      return "2nd";
    }
    if (roundId == "3") {
      return "3rd";
    }
    return "${roundId}th";
  }
}

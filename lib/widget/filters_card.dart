import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/view/main/main_page_bloc.dart';
import 'package:logstf/util/application_localization.dart';

class FiltersCard extends StatelessWidget {
  final String map;
  final String uploader;
  final String title;
  final String player;

  const FiltersCard({Key key, this.map, this.uploader, this.title, this.player})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_areFiltersPresent()) {
      return Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getFiltersWidgets(context),
            ),
            Center(
                child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                logsSearchBloc.clearFilters();
              },
            ))
          ]));
    } else {
      return Container(
        width: 0.0,
        height: 0.0,
      );
    }
  }

  List<Widget> _getFiltersWidgets(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    List<Widget> widgets = List();
    if (map != null && map.isNotEmpty) {
      widgets.add(Text("${applicationLocalization.getText("log_search_map")}: $map"));
    }
    if (uploader != null && uploader.isNotEmpty) {
      widgets.add(Text("${applicationLocalization.getText("log_search_uploader")}: $uploader"));
    }
    if (title != null && title.isNotEmpty) {
      widgets.add(Text("${applicationLocalization.getText("log_search_title")}: $title"));
    }
    if (player != null && player.isNotEmpty) {
      widgets.add(Text("${applicationLocalization.getText("log_search_player_steam_id")}: $player"));
    }

    return widgets;
  }

  bool _areFiltersPresent() {
    return (map != null && map.isNotEmpty) ||
        (uploader != null && uploader.isNotEmpty) ||
        (title != null && title.isNotEmpty) ||
        (player != null && player.isNotEmpty);
  }
}

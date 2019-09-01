import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';

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
              children: _getFiltersWidgets(),
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

  List<Widget> _getFiltersWidgets() {
    List<Widget> widgets = List();
    if (map != null && map.isNotEmpty) {
      widgets.add(Text("Map: $map"));
    }
    if (uploader != null && uploader.isNotEmpty) {
      widgets.add(Text("Uploader: $uploader"));
    }
    if (title != null && title.isNotEmpty) {
      widgets.add(Text("Title: $title"));
    }
    if (player != null && player.isNotEmpty) {
      widgets.add(Text("Player: $player"));
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logstf/ui/common/widget/logs_button.dart';

class AuthorWidget extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String pageButtonName;
  final String description;
  final Function onPageClicked;
  final Function onSteamClicked;

  AuthorWidget(this.avatarUrl, this.name, this.pageButtonName, this.description,
      this.onPageClicked, this.onSteamClicked);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(
      ClipOval(
        child: Image.network(
          avatarUrl,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          loadingBuilder: (context, widget, loadingProgress) {
            if (loadingProgress == null) return widget;
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          },
        ),
      ),
    );
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
    );
    widgets.add(
      Text(
        name,
        style: TextStyle(fontSize: 20),
      ),
    );
    widgets.add(
      Text(
        description,
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
    );
    widgets.add(
      Column(
        children: [
          LogsButton(
            text: pageButtonName,
            backgroundColor: Colors.grey,
            onPressed: () {
              onPageClicked();
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          LogsButton(
            text: "Steam",
            backgroundColor: Colors.grey,
            onPressed: () {
              onSteamClicked();
            },
          ),
        ],
      ),
    );

    return Container(
        margin: EdgeInsets.only(left: 5), child: Column(children: widgets));
  }
}

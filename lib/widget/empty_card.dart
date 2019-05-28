import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final String description;

  const EmptyCard({Key key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
          margin: EdgeInsets.all(10),
          child: Container(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 200,
                        child: Text(
                          description,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ])))
    ]));
  }
}

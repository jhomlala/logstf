import 'package:flutter/material.dart';

class TeamsScoreTableWidget extends StatelessWidget {
  final int bluTeamScore;
  final int redTeamScore;

  const TeamsScoreTableWidget({Key key, this.bluTeamScore, this.redTeamScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
            Text(
              "BLU",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
            Text("$bluTeamScore",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
            Text("$redTeamScore",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
            Text(
              "RED",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
          ]),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/util/pair.dart';

class ComparisonCard extends StatelessWidget {
  final String title;
  final double playerValue;
  final double comparedPlayerValue;
  final String playerName;
  final String comparedPlayerName;
  final bool reversed;
  final int decimalPlaces;

  ComparisonCard(
      {Key key,
      this.title,
      this.playerValue,
      this.comparedPlayerValue,
      this.playerName,
      this.comparedPlayerName,
      this.reversed = false,
      this.decimalPlaces = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String winnerText;
    Color playerColor;
    Color comparedPlayerColor;
    double percentage;
    String winnerPlayer;
    String loserPlayer;

    var playersPair = _getWinnerAndLoser();
    var colorsPair = _getPlayerColors();

    if (reversed){
      playersPair = Pair.reverse(playersPair);
      colorsPair = Pair.reverse(colorsPair);
    }

    winnerPlayer = playersPair.first;
    loserPlayer = playersPair.second;


    playerColor = colorsPair.first;
    comparedPlayerColor = colorsPair.second;

    percentage = _getPercentage();
    winnerText = _getWinnerText();

    return Card(
      child: Column(children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
        Text(
          winnerText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        _getWinnerDescriptionWidget(winnerPlayer, loserPlayer, percentage),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(children: [
              Container(
                constraints: BoxConstraints(maxWidth: 100),
                child: Text(playerName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(playerValue.toStringAsFixed(decimalPlaces),
                  style: TextStyle(fontSize: 30, color: playerColor))
            ]),
            Column(children: [
              Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: Text(comparedPlayerName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 24))),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(comparedPlayerValue.toStringAsFixed(decimalPlaces),
                  style: TextStyle(fontSize: 30, color: comparedPlayerColor))
            ]),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        )
      ]),
    );
  }

  Widget _getWinnerDescriptionWidget(
      String winnerPlayer, String loserPlayer, double percentage) {
    if (playerValue == comparedPlayerValue) {
      return Container();
    } else {

      String phrase = "more";
      if (reversed){
        phrase = "less";
      }

      return RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
              fontStyle: FontStyle.italic
          ),
          children: <TextSpan>[
            new TextSpan(
                text: "$winnerPlayer",
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new TextSpan(text: " had"),
            new TextSpan(
                text: " ${percentage.toStringAsFixed(0)}%",
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new TextSpan(text: " $phrase ${title.toLowerCase()} than "),
            new TextSpan(
                text: "$loserPlayer.",
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  }

  String _getWinnerText() {
    if (reversed){
      if (playerValue < comparedPlayerValue) {
        return "$playerName wins!";
      } else if (playerValue > comparedPlayerValue) {
        return "$comparedPlayerName wins!";
      } else {
        return "It's a tie!";
      }
    }


    if (playerValue > comparedPlayerValue) {
      return "$playerName wins!";
    } else if (playerValue < comparedPlayerValue) {
      return "$comparedPlayerName wins!";
    } else {
      return "It's a tie!";
    }
  }

  Pair<Color, Color> _getPlayerColors() {
    if (playerValue > comparedPlayerValue) {
      return Pair(Colors.green, Colors.red);
    } else if (playerValue < comparedPlayerValue) {
      return Pair(Colors.red, Colors.green);
    } else {
      return Pair(Colors.black, Colors.black);
    }
  }

  double _getPercentage() {
    if (reversed){
      if (playerValue > comparedPlayerValue) {
        return (1 - comparedPlayerValue / playerValue).abs() * 100;
      } else if (playerValue < comparedPlayerValue) {
        return (1 - playerValue / comparedPlayerValue).abs() * 100;
      } else {
        return 0;
      }
    }

    if (playerValue > comparedPlayerValue) {
      return (1 - playerValue / comparedPlayerValue).abs() * 100;
    } else if (playerValue < comparedPlayerValue) {
      return (1 - comparedPlayerValue / playerValue).abs() * 100;
    } else {
      return 0;
    }
  }

  Pair<String, String> _getWinnerAndLoser() {
    if (playerValue > comparedPlayerValue) {
      return Pair(playerName, comparedPlayerName);
    } else if (playerValue < comparedPlayerValue) {
      return Pair(comparedPlayerName, playerName);
    } else {
      return Pair(playerName, playerName);
    }
  }
}

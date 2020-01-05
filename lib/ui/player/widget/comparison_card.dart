import 'package:flutter/material.dart';
import 'package:logstf/utils/application_localization.dart';
import 'package:logstf/utils/pair.dart';

class ComparisonCard extends StatelessWidget {
  final String title;
  final String plural;
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
      this.decimalPlaces = 0,
      this.plural})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationLocalization applicationLocalization =
        ApplicationLocalization.of(context);
    String winnerText;
    Color playerColor;
    Color comparedPlayerColor;
    double percentage;
    String winnerPlayer;
    String loserPlayer;

    var playersPair = _getWinnerAndLoser();
    var colorsPair = _getPlayerColors(context);

    if (reversed) {
      playersPair = Pair.reverse(playersPair);
      colorsPair = Pair.reverse(colorsPair);
    }

    winnerPlayer = playersPair.first;
    loserPlayer = playersPair.second;

    playerColor = colorsPair.first;
    comparedPlayerColor = colorsPair.second;

    percentage = _getPercentage();
    winnerText = _getWinnerText(applicationLocalization);

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
        _getWinnerDescriptionWidget(winnerPlayer, loserPlayer, percentage,
            context, applicationLocalization),
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
      String winnerPlayer,
      String loserPlayer,
      double percentage,
      BuildContext context,
      ApplicationLocalization applicationLocalization) {
    if (playerValue == comparedPlayerValue) {
      return Container();
    } else {
      String phrase = "${applicationLocalization.getText("log_compare_more")}";
      if (reversed) {
        phrase = "${applicationLocalization.getText("log_compare_less")}";
      }

      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).textTheme.body1.color,
              fontStyle: FontStyle.italic),
          children: <TextSpan>[
            TextSpan(
                text: "$winnerPlayer",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: " ${applicationLocalization.getText("log_compare_had")}"),
            TextSpan(
                text: " ${percentage.toStringAsFixed(0)}%",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    " $phrase $plural ${applicationLocalization.getText("log_compare_than")} "),
            TextSpan(
                text: "$loserPlayer.",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  }

  String _getWinnerText(ApplicationLocalization applicationLocalization) {
    if (reversed) {
      if (playerValue < comparedPlayerValue) {
        return "$playerName ${applicationLocalization.getText("log_compare_wins")}!";
      } else if (playerValue > comparedPlayerValue) {
        return "$comparedPlayerName ${applicationLocalization.getText("log_compare_wins")}!";
      } else {
        return "${applicationLocalization.getText("log_compare_tie")}!";
      }
    }

    if (playerValue > comparedPlayerValue) {
      return "$playerName ${applicationLocalization.getText("log_compare_wins")}!";
    } else if (playerValue < comparedPlayerValue) {
      return "$comparedPlayerName ${applicationLocalization.getText("log_compare_wins")}!";
    } else {
      return "${applicationLocalization.getText("log_compare_tie")}!";
    }
  }

  Pair<Color, Color> _getPlayerColors(BuildContext context) {
    if (playerValue > comparedPlayerValue) {
      return Pair(Colors.green, Colors.red);
    } else if (playerValue < comparedPlayerValue) {
      return Pair(Colors.red, Colors.green);
    } else {
      return Pair(Theme.of(context).textTheme.body1.color,
          Theme.of(context).textTheme.body1.color);
    }
  }

  double _getPercentage() {
    double playerValue = this.playerValue;
    double comparedPlayerValue = this.comparedPlayerValue;
    if (playerValue != 0 && comparedPlayerValue == 0) {
      return playerValue * 100;
    }
    if (playerValue == 0 && comparedPlayerValue != 0) {
      return comparedPlayerValue * 100;
    }

    if (reversed) {
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

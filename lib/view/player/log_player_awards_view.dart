import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/application_localization.dart';

class LogPlayerAwardsView extends StatelessWidget {
  final Log _log;
  final Player _player;

  const LogPlayerAwardsView(this._log, this._player);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: getAwards(context),
          ),
        ));
  }

  List<Widget> getAwards(BuildContext context) {
    ApplicationLocalization applicationLocalization =
        ApplicationLocalization.of(context);
    List<Widget> awards = List();
    awards.add(_getAwardCard(
        applicationLocalization.getText("log_award_mvp_title"),
        applicationLocalization.getText("log_award_mvp_description"),
        LogHelper.getPlayerSortedByMVPScore(_log),
        context));

    awards.add(_getAwardCard(
        applicationLocalization.getText("log_award_kills_title"),
        applicationLocalization.getText("log_award_kills_description"),
        LogHelper.getPlayersSortedByKills(_log),
        context));

    awards.add(_getAwardCard(
        applicationLocalization.getText("log_award_assists_title"),
        applicationLocalization.getText("log_award_assists_description"),
        LogHelper.getPlayersSortedByAssists(_log, true),
        context));

    awards.add(_getAwardCard(
        applicationLocalization.getText("log_award_damage_title"),
        applicationLocalization.getText("log_award_damage_description"),
        LogHelper.getPlayersSortedByDamage(_log),
        context));

    awards.add(_getAwardCard(
        applicationLocalization.getText("log_award_medic_kills_title"),
        applicationLocalization.getText("log_award_medic_kills_description"),
        LogHelper.getPlayersSortedByMedicKills(_log),
        context));

    awards.add(_getAwardCard(
        applicationLocalization.getText("log_award_kpd_title"),
        applicationLocalization.getText("log_award_kpd_description"),
        LogHelper.getPlayersSortedByKPD(_log),
        context));

    awards.add(_getAwardCard(
        applicationLocalization.getText("log_award_kapd_title"),
        applicationLocalization.getText("log_award_kapd_description"),
        LogHelper.getPlayersSortedByKPD(_log),
        context));

    if (_player.dapm >= 500) {
      awards.add(_getSpecialAwardCard(
          applicationLocalization
              .getText("log_player_awards_500_dpm_club_title"),
          applicationLocalization
              .getText("log_player_awards_500_dpm_club_description")));
    }

    if (_player.dmg >= 10000) {
      awards.add(_getSpecialAwardCard(
          applicationLocalization
              .getText("log_player_awards_10k_damage_title"),
          applicationLocalization
              .getText("log_player_awards_10k_damage_description")));
    }

    if (_player.deaths == 0) {
      awards.add(_getSpecialAwardCard(
          applicationLocalization
              .getText("log_player_awards_deathless_title"),
          applicationLocalization
              .getText("log_player_awards_10k_deathless_description")));
    }

    return awards;
  }

  Card _getSpecialAwardCard(String name, String description) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(name, style: TextStyle(fontSize: 20)),
        ]),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        Text(description),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
      ]),
    );
  }

  Card _getAwardCard(String name, String description,
      List<Player> sortedPlayers, BuildContext context) {
    ApplicationLocalization applicationLocalization =
        ApplicationLocalization.of(context);
    int playerIndex = 0;
    for (int index = 0; index < sortedPlayers.length; index++) {
      if (sortedPlayers[index].steamId == _player.steamId) {
        playerIndex = index;
        break;
      }
    }
    var position = playerIndex + 1;

    String placeImage;
    if (position == 1) {
      placeImage = "assets/first_place.png";
    }
    if (position == 2) {
      placeImage = "assets/second_place.png";
    } else if (position == 3) {
      placeImage = "assets/third_place.png";
    }

    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(name, style: TextStyle(fontSize: 20)),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "${applicationLocalization.getText("log_player_awards_position")}: $position",
              style: TextStyle(fontSize: 16),
            ),
            placeImage != null
                ? Image.asset(
                    placeImage,
                    height: 20,
                    width: 20,
                  )
                : Container()
          ]),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/utils/application_localization.dart';
import 'package:logstf/ui/log/widget/award_card.dart';

class LogAwardsFragment extends StatefulWidget {
  final Log log;

  const LogAwardsFragment( this.log);

  @override
  _LogAwardsFragmentState createState() => _LogAwardsFragmentState();
}

class _LogAwardsFragmentState extends State<LogAwardsFragment> {
  Log get _log => widget.log;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    return Container(
        padding: EdgeInsets.all(10),
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            AwardCard(
              awardName: applicationLocalization.getText("log_award_mvp_title"),
              players: getTopMVPPlayers(),
              log: _log,
              description:
                  applicationLocalization.getText("log_award_mvp_description"),
            ),
            AwardCard(
              awardName:
                  applicationLocalization.getText("log_award_kills_title"),
              players: getTopKillPlayers(),
              log: _log,
              description: applicationLocalization
                  .getText("log_award_kills_description"),
            ),
            AwardCard(
              awardName:
                  applicationLocalization.getText("log_award_assists_title"),
              players: getTopAssistsPlayers(),
              log: _log,
              description: applicationLocalization
                  .getText("log_award_assists_description"),
            ),
            AwardCard(
              awardName:
                  applicationLocalization.getText("log_award_damage_title"),
              players: getTopDamagePlayers(),
              log: _log,
              description: applicationLocalization
                  .getText("log_award_damage_description"),
            ),
            AwardCard(
              awardName: applicationLocalization
                  .getText("log_award_medic_kills_title"),
              players: getTopDamagePlayers(),
              log: _log,
              description: applicationLocalization
                  .getText("log_award_medic_kills_description"),
            ),
            AwardCard(
              awardName: applicationLocalization.getText("log_award_kpd_title"),
              players: getTopKPDPlayers(),
              log: _log,
              description:
                  applicationLocalization.getText("log_award_kpd_description"),
            ),
            AwardCard(
              awardName:
                  applicationLocalization.getText("log_award_kapd_title"),
              players: getTopKPDPlayers(),
              log: _log,
              description:
                  applicationLocalization.getText("log_award_kapd_description"),
            )
          ],
        )));
  }

  List<Player> getTopList(List<Player> sortedList) {
    int count = sortedList.length;
    if (count <= 3) {
      return sortedList;
    } else {
      return sortedList.sublist(0, 3);
    }
  }

  List<Player> getTopKillPlayers() {
    return getTopList(LogHelper.getPlayersSortedByKills(_log));
  }

  List<Player> getTopAssistsPlayers() {
    return getTopList(LogHelper.getPlayersSortedByAssists(_log, false));
  }

  List<Player> getTopDamagePlayers() {
    return getTopList(LogHelper.getPlayersSortedByDamage(_log));
  }

  List<Player> getTopMedicKillsPlayers() {
    return getTopList(LogHelper.getPlayersSortedByMedicKills(_log));
  }

  List<Player> getTopMVPPlayers() {
    return getTopList(LogHelper.getPlayerSortedByMVPScore(_log));
  }

  List<Player> getTopKPDPlayers() {
    return getTopList(LogHelper.getPlayersSortedByKPD(_log));
  }

  List<Player> getTopKAPDPlayers() {
    return getTopList(LogHelper.getPlayersSortedByKAPD(_log));
  }
}

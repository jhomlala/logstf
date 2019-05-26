import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:rxdart/rxdart.dart';

class LogBloc {
  final BehaviorSubject<Log> logSubject = BehaviorSubject();
  final BehaviorSubject<Player> selectedPlayerSubject = BehaviorSubject();

  void dispose() async {
    await logSubject.drain();
    logSubject.close();
    await selectedPlayerSubject.drain();
    selectedPlayerSubject.close();
  }

  void setLog(Log log) {
    logSubject.value = log;
  }

  void setPlayer(Player player) {
    selectedPlayerSubject.value = player;
  }


}

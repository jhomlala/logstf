import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:rxdart/rxdart.dart';

class AppStateManager {
  final PlayersObservedLocalProvider playersObservedLocalProvider;
  final BehaviorSubject<List<PlayerObserved>> playersObservedSubject =
  BehaviorSubject();
  SearchData searchData;

  AppStateManager(this.playersObservedLocalProvider);

  void refreshPlayersObserved() {
    playersObservedSubject.value = List();
  }

  void dispose() {
    playersObservedSubject.close();
  }
}

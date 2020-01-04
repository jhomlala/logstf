import 'package:dio/dio.dart';
import 'package:logstf/model/external/steam_players_response.dart';
import 'package:logstf/repository/external/steam_remote_repository.dart';

class SteamRemoteProvider {
  SteamRemoteRepository _repository;

  SteamRemoteProvider(Dio dio) {
    _repository = SteamRemoteRepository(dio);
  }

  Future<SteamPlayersResponse> getSteamPlayers(String steamIds) async {
    return _repository.getSteamPlayers(steamIds);
  }
}

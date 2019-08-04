import 'package:logstf/model/steam_players_response.dart';
import 'package:logstf/repository/remote/steam_remote_repository.dart';

class SteamRemoteProvider{

  SteamRemoteRepository _repository = SteamRemoteRepository();

  Future<SteamPlayersResponse> getSteamPlayers(String steamIds) async{
    return _repository.getSteamPlayers(steamIds);
  }
}
import 'package:logstf/model/external/steam_players_response.dart';
import 'package:logstf/repository/external/steam_remote_repository.dart';

class SteamRemoteProvider{
  final SteamRemoteRepository _repository = SteamRemoteRepository();

  Future<SteamPlayersResponse> getSteamPlayers(String steamIds) async{
    return _repository.getSteamPlayers(steamIds);
  }
}

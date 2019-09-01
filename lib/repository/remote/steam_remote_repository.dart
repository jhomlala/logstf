import 'package:dio/dio.dart';
import 'package:logstf/model/steam_players_response.dart';
import 'package:logstf/util/app_const.dart';

class SteamRemoteRepository {
  Dio _dio = Dio();

  Future<SteamPlayersResponse> getSteamPlayers(String steamIds) async {
    Uri uri = Uri.parse("${AppConst.steamApiUrl}$steamIds");
    Response response = await _dio.request(uri.toString());
    return SteamPlayersResponse.fromJson(response.data);
  }
}

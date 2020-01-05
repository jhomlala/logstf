import 'package:dio/dio.dart';
import 'package:logstf/model/external/steam_players_response.dart';
import 'package:logstf/utils/app_const.dart';

class SteamRemoteRepository {
  final Dio dio;
  SteamRemoteRepository(this.dio);

  Future<SteamPlayersResponse> getSteamPlayers(String steamIds) async {
    Uri uri = Uri.parse("${AppConst.steamApiUrl}$steamIds");
    Response response = await dio.request(uri.toString());
    return SteamPlayersResponse.fromJson(response.data);
  }
}

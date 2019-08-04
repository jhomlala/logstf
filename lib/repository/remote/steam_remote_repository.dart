import 'package:dio/dio.dart';
import 'package:logstf/model/steam_players_response.dart';

class SteamRemoteRepository{
  Dio dio = Dio();

  Future<SteamPlayersResponse> getSteamPlayers(String steamIds) async{
    Uri uri = Uri.parse("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=293C752465889A86B1771C9C524B6528&steamids=$steamIds");
    Response response = await dio.request(uri.toString());
    print("Response: " + response.toString());
    return SteamPlayersResponse.fromJson(response.data);
  }

}
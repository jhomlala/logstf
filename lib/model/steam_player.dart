class SteamPlayer {
  String steamid;
  int communityvisibilitystate;
  int profilestate;
  String personaname;
  int lastlogoff;
  String profileurl;
  String avatar;
  String avatarmedium;
  String avatarfull;
  int personastate;
  String realname;
  String primaryclanid;
  int timecreated;
  int personastateflags;
  String loccountrycode;
  String locstatecode;
  int loccityid;

  SteamPlayer({
    this.steamid,
    this.communityvisibilitystate,
    this.profilestate,
    this.personaname,
    this.lastlogoff,
    this.profileurl,
    this.avatar,
    this.avatarmedium,
    this.avatarfull,
    this.personastate,
    this.realname,
    this.primaryclanid,
    this.timecreated,
    this.personastateflags,
    this.loccountrycode,
    this.locstatecode,
    this.loccityid,
  });

  factory SteamPlayer.fromJson(Map<String, dynamic> json) => new SteamPlayer(
    steamid: json["steamid"],
    communityvisibilitystate: json["communityvisibilitystate"],
    profilestate: json["profilestate"],
    personaname: json["personaname"],
    lastlogoff: json["lastlogoff"],
    profileurl: json["profileurl"],
    avatar: json["avatar"],
    avatarmedium: json["avatarmedium"],
    avatarfull: json["avatarfull"],
    personastate: json["personastate"],
    realname: json["realname"],
    primaryclanid: json["primaryclanid"],
    timecreated: json["timecreated"],
    personastateflags: json["personastateflags"],
    loccountrycode: json["loccountrycode"],
    locstatecode: json["locstatecode"],
    loccityid: json["loccityid"],
  );

  Map<String, dynamic> toJson() => {
    "steamid": steamid,
    "communityvisibilitystate": communityvisibilitystate,
    "profilestate": profilestate,
    "personaname": personaname,
    "lastlogoff": lastlogoff,
    "profileurl": profileurl,
    "avatar": avatar,
    "avatarmedium": avatarmedium,
    "avatarfull": avatarfull,
    "personastate": personastate,
    "realname": realname,
    "primaryclanid": primaryclanid,
    "timecreated": timecreated,
    "personastateflags": personastateflags,
    "loccountrycode": loccountrycode,
    "locstatecode": locstatecode,
    "loccityid": loccityid,
  };
}

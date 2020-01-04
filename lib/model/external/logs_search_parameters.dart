class LogsSearchParameters {
  String player;
  String uploader;
  String title;
  String map;
  int limit;
  int offset;

  LogsSearchParameters({
    this.player,
    this.uploader,
    this.title,
    this.map,
    this.limit,
    this.offset,
  });

  factory LogsSearchParameters.fromJson(Map<String, dynamic> json) => new LogsSearchParameters(
    player: json["player"],
    uploader: json["uploader"],
    title: json["title"],
    map: json["map"],
    limit: json["limit"],
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "player": player,
    "uploader": uploader,
    "title": title,
    "map": map,
    "limit": limit,
    "offset": offset,
  };
}
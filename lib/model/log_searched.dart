class LogSearched {
  int id;
  String title;
  String map;
  int date;
  int views;
  int players;

  LogSearched({
    this.id,
    this.title,
    this.map,
    this.date,
    this.views,
    this.players,
  });

  factory LogSearched.fromJson(Map<String, dynamic> json) => new LogSearched(
        id: json["id"],
        title: json["title"],
        map: json["map"],
        date: json["date"],
        views: json["views"],
        players: json["players"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "map": map,
        "date": date,
        "views": views,
        "players": players,
      };
}

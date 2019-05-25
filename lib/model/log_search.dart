class LogSearch {
  int id;
  String title;
  String map;
  int date;
  int views;
  int players;

  LogSearch({
    this.id,
    this.title,
    this.map,
    this.date,
    this.views,
    this.players,
  });

  factory LogSearch.fromJson(Map<String, dynamic> json) => new LogSearch(
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

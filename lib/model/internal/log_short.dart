class LogShort {
  int id;
  String title;
  String map;
  int date;
  int views;
  int players;

  LogShort({
    this.id,
    this.title,
    this.map,
    this.date,
    this.views,
    this.players,
  });

  factory LogShort.placeholder(int id) =>  LogShort(
      id: -1, title: null, map: null, date: null, views: null, players: null);

  factory LogShort.fromJson(Map<String, dynamic> json) =>  LogShort(
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

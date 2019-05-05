import 'package:logstf/model/uploader.dart';

class Info {
  final String map;
  final String title;
  final int date;
  final Uploader uploader;

  Info({this.map, this.title, this.date, this.uploader});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
      map: json["map"],
      title: json["title"],
      date: json["date"],
      uploader: Uploader.fromJson(json["uploader"]));
}

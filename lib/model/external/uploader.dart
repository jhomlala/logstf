class Uploader {
  final String id;
  final String name;
  final String info;

  Uploader({this.id, this.name, this.info});

  factory Uploader.fromJson(Map<String, dynamic> json) =>
      Uploader(id: json["id"], name: json["name"], info: json["info"]);
}

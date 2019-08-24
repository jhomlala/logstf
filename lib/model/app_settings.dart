import 'dart:ui';

class AppSettings {
  String appColor;

  AppSettings({this.appColor});

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      AppSettings(appColor: json["appColor"]);

  Map<String, dynamic> toJson() => {"appColor": appColor};

}

class AppSettings {
  String appColor;
  String appBrightness;

  AppSettings({this.appColor, this.appBrightness});

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      AppSettings(appColor: json["appColor"], appBrightness: json["appBrightness"]);

  Map<String, dynamic> toJson() =>
      {"appColor": appColor, "appBrightness": appBrightness};
}

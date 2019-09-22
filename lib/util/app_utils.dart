import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static Color blueColor = Color.fromARGB(255, 32, 99, 155);
  static Color redColor = Color.fromARGB(255, 237, 85, 59);
  static Color darkBlueColor = Color.fromARGB(255, 23, 63, 95);
  static Color seashellColor = Color.fromARGB(255, 245, 245, 245);
  static Color lightGreyColor = Color.fromARGB(255, 230, 230, 230);
  static Color darkGreyColor = Color.fromARGB(255, 90,90,90);
  static Color greyColor = Color.fromARGB(255, 66,66,66);

  static int convertSteamId3ToSteamId64(String steamId) {
    String steamIdFixed = steamId.replaceAll("[", "");
    steamIdFixed = steamIdFixed.replaceAll("]", "").trim();
    var split = steamIdFixed.split(":");
    var id = split[2];
    return 76561197960265728 + int.parse(id);
  }

  static Color getColor(String colorName) {
    switch (colorName) {
      case "Purple":
        return Colors.deepPurple;
      case "Orange":
        return Colors.orange;
      case "Green":
        return Colors.green;
      case "Blue":
        return Colors.blue;
      case "Red":
        return Colors.red;
      case "Pink":
        return Colors.pink;
      case "Black":
        return Colors.black;
    }
    return Colors.deepPurple;
  }

  static launchWebPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static double roundDoubleToFractionDigits(double value, int fractionDigits) {
    return double.parse(value.toStringAsFixed(fractionDigits));
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static Brightness getBrightness(String appBrightness) {
   int brightnessIndex = int.parse(appBrightness);
   if (brightnessIndex == Brightness.light.index){
     return Brightness.light;
   } else {
     return Brightness.dark;
   }
  }

  static Color getBorderColor(BuildContext context){
    Brightness brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light){
      return lightGreyColor;
    } else {
      return darkGreyColor;
    }
  }
  static Color getBackgroundColor(BuildContext context){
    Brightness brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light){
      return Colors.white;
    } else {
      return greyColor;
    }
  }

  static getIconColor(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light){
      return Colors.black;
    } else {
      return Colors.white;
    }
  }


}

import 'dart:ui';

import 'package:flutter/material.dart';

class AppUtils {
  static Color blueColor = Color.fromARGB(255, 32, 99, 155);
  static Color redColor = Color.fromARGB(255, 237, 85, 59);
  static Color darkBlueColor = Color.fromARGB(255, 23, 63, 95);
  static Color seashellColor = Color.fromARGB(255, 245, 245, 245);
  static Color lightGreyColor = Color.fromARGB(255, 230, 230, 230);


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
    }
    return Colors.deepPurple;
  }



}
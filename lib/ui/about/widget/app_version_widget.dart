import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppVersionWidget extends StatefulWidget {
  @override
  _AppVersionWidgetState createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersionWidget> {
  PackageInfo _packageInfo;

  _getVersion() async {
    _packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  @override
  Widget build(BuildContext context) {
    if (_packageInfo != null) {
      return Text(
        "${_packageInfo.version} (build ${_packageInfo.buildNumber})",
        style: TextStyle(fontSize: 25),
      );
    } else {
      return Container();
    }
  }
}

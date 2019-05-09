import 'package:flutter/material.dart';
import 'package:logstf/util/app_utils.dart';

class TableHeaderWidget extends StatelessWidget {

  final String headerName;

  const TableHeaderWidget(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: AppUtils.darkBlueColor,
      ),
      child: Center(
          child: Text(
            headerName,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

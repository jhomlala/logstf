import 'package:flutter/material.dart';
import 'package:logstf/util/app_utils.dart';

class TableHeaderWidget extends StatelessWidget {

  final String headerName;
  final int roundedBorder;

  const TableHeaderWidget(this.headerName, this.roundedBorder);

  @override
  Widget build(BuildContext context) {

    var borderRadius = BorderRadius.only();
    if (roundedBorder == 1){
      borderRadius = BorderRadius.only(topLeft: Radius.circular(10));
    }
    if (roundedBorder == 2){
      borderRadius = BorderRadius.only(topRight: Radius.circular(10));
    }

    return Container(color: Colors.deepPurple, child: Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: AppUtils.darkBlueColor,
      ),
      child: Center(
          child: Text(
            headerName,
            style: TextStyle(color: Colors.white),
          )),
    ));
  }
}

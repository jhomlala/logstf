import 'package:flutter/material.dart';

class LogsButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color backgroundColor;

  const LogsButton({Key key, this.text, this.onPressed, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: backgroundColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}

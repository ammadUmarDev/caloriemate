import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class H1TextStyle extends TextStyle {
  H1TextStyle({this.color});
  final fontFamily = "Montserrat";
  final fontSize = kH1Size;
  final Color color;
  final fontWeight = FontWeight.w600;
}

class H1 extends StatelessWidget {
  H1({
    this.textBody,
    this.color = kTextDarkColor,
  });
  final String textBody;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: H1TextStyle(color: color),
    );
  }
}

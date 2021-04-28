import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';
import '../constants.dart';
import 'h3.dart';

// ignore: must_be_immutable
class ButtonErims extends StatefulWidget {
  ButtonErims({@required this.onTap, @required this.labelText});

  dynamic Function(Function, Function, ButtonState) onTap;
  String labelText;

  @override
  _ButtonErimsState createState() => _ButtonErimsState();
}

class _ButtonErimsState extends State<ButtonErims> {
  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 40,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: widget.onTap,
      child: Text(widget.labelText, style: H3TextStyle(color: kTextLightColor)),
      loader: Container(
        padding: EdgeInsets.all(10),
        child: SpinKitRotatingCircle(
          color: kTextLightColor,
        ),
      ),
      borderRadius: 12.0,
      color: kPrimaryAccentColor,
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 2.0,
      ),
    );
  }
}

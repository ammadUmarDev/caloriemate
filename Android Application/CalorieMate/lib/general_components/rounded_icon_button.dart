import 'package:calorie_mate/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor,
    this.icon,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color color, textColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();

    return Container(
      // height: 212,
      // width: 180,
      height: pageHeight * 0.25,
      width: pageWidth * 0.436,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: <Widget>[
            Spacer(),
            icon,
            // Icon(
            //   icon,
            //   color: textColor,
            //   size: 90,
            // ),
            Spacer(),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

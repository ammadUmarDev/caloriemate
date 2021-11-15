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
    return Container(
      height: 182,
      width: 156,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          primary: color,
          // elevation: 3,
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
                fontSize: 15,
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

import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  SelectionCard(
      {@required this.color,
      this.cardChild,
      this.onPress,
      this.textColor,
      this.icon,
      this.text});

  final Color color, textColor;
  final Widget cardChild;
  final Function onPress;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 175,
        height: 200,
        child: Column(
          children: <Widget>[
            Spacer(),
            Icon(
              icon,
              color: textColor,
              size: 90,
            ),
            Spacer(),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
          ],
        ),
        // margin: EdgeInsets.only(left: 16.0, right: 16, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

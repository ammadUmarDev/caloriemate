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
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();
    return GestureDetector(
      onTap: onPress,
      child: Container(
        // width: 175,
        // height: 200,
        width: pageWidth * 0.436,
        height: pageHeight * 0.25,
        child: Column(
          children: <Widget>[
            Spacer(),
            icon,
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
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              spreadRadius: 1.5,
              offset: Offset(0, 3.0),
              // shadow direction: bottom right
            )
          ],
        ),
      ),
    );
  }
}

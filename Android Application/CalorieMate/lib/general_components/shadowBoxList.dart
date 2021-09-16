import 'package:flutter/material.dart';
import '../constants.dart';

class ShadowBoxList extends StatelessWidget {
  final Icon icon;
  final widgetColumn;
  final Function onTapFunction;

  ShadowBoxList({this.icon, this.onTapFunction, this.widgetColumn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: Offset(1.0, 1.0),
                // shadow direction: bottom right
              )
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Center(
                  child: icon,
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widgetColumn,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onTapFunction,
      ),
    );
  }
}

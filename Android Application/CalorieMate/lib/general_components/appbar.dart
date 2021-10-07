import 'package:calorie_mate/screens/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import 'h1.dart';
import 'h2.dart';
import 'h3.dart';

class AppBarPageName extends StatelessWidget implements PreferredSizeWidget {
  AppBarPageName({this.pageName, this.helpAlertTitle, this.helpAlertBody});
  final pageName;
  String helpAlertTitle;
  String helpAlertBody;

  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: kPrimaryDarkColor, //change your color here
      ),
      backgroundColor: Colors.transparent,
      title: H1(
        textBody: pageName,
        color: kTextDarkColor,
      ),
      elevation: 0,
      actions: [
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.help,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
                Alert(
                    context: context,
                    title: helpAlertTitle,
                    closeIcon: Icon(
                      FontAwesomeIcons.timesCircle,
                      color: kPrimaryLightColor,
                    ),
                    style: AlertStyle(
                      overlayColor: Colors.black45,
                      titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                    ),
                    content: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: helpAlertBody),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: Colors.white,
                        height: 0,
                        child: SizedBox(height: 0),
                        onPressed: () => {},
                      ),
                    ]).show();
              },
            ),
          ),
        ),
        SizedBox(
          width: 0,
        ),
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.home_filled,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DashBoard();
                  },
                ));
              },
            ),
          ),
        ),
        SizedBox(
          width: 0,
        ),
      ],
    );
  }
}

class AppBarWithoutPageName extends StatelessWidget
    implements PreferredSizeWidget {
  AppBarWithoutPageName({this.helpAlertTitle, this.helpAlertBody});
  String helpAlertTitle;
  String helpAlertBody;

  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: kPrimaryDarkColor, //change your color here
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.help,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
                Alert(
                    context: context,
                    title: helpAlertTitle,
                    closeIcon: Icon(
                      FontAwesomeIcons.timesCircle,
                      color: kPrimaryLightColor,
                    ),
                    style: AlertStyle(
                      overlayColor: Colors.black45,
                      titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                    ),
                    content: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: helpAlertBody),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: Colors.white,
                        height: 0,
                        child: SizedBox(height: 0),
                        onPressed: () => {},
                      ),
                    ]).show();
              },
            ),
          ),
        ),
        SizedBox(
          width: 0,
        ),
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.home_filled,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DashBoard();
                  },
                ));
              },
            ),
          ),
        ),
        SizedBox(
          width: 0,
        ),
      ],
    );
  }
}

class AppBarWithoutHome extends StatelessWidget implements PreferredSizeWidget {
  AppBarWithoutHome({this.pageName, this.helpAlertTitle, this.helpAlertBody});
  final pageName;
  String helpAlertTitle;
  String helpAlertBody;

  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: kPrimaryDarkColor, //change your color here
      ),
      backgroundColor: Colors.transparent,
      title: H1(
        textBody: pageName,
        color: kTextDarkColor,
      ),
      elevation: 0,
      actions: [
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.help,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
                Alert(
                    context: context,
                    title: helpAlertTitle,
                    closeIcon: Icon(
                      FontAwesomeIcons.timesCircle,
                      color: kPrimaryLightColor,
                    ),
                    style: AlertStyle(
                      overlayColor: Colors.black45,
                      titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                    ),
                    content: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: helpAlertBody),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: Colors.white,
                        height: 0,
                        child: SizedBox(height: 0),
                        onPressed: () => {},
                      ),
                    ]).show();
              },
            ),
          ),
        ),
        SizedBox(
          width: 0,
        ),
      ],
    );
  }
}

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
  AppBarPageName(
      {this.pageName,
      this.helpAlertTitle,
      this.helpAlertBody,
      this.leading = true});
  final pageName;
  String helpAlertTitle;
  String helpAlertBody;
  bool leading;

  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: kNavyBlue,
      title: H1(textBody: pageName, color: Colors.white),
      titleSpacing: 20,
      elevation: 2,
      automaticallyImplyLeading: leading,
      actions: [
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 46,
                height: 46,
                child: Icon(
                  Icons.help,
                  color: Colors.white,
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
                child: Icon(Icons.home_filled, color: Colors.white),
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
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: kPrimaryDarkColor, //change your color here
      ),
      backgroundColor: kNavyBlue,
      elevation: 0,
      titleSpacing: 20,
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
                  color: Colors.white,
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
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white //change your color here
          ),
      backgroundColor: kNavyBlue,
      title: H1(
        textBody: pageName,
        color: Colors.white,
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 20,
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
                  color: Colors.white,
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

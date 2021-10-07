import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/buttonErims.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/general_components/rounded_password_field.dart';
import 'package:calorie_mate/general_components/shadowBoxList.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/profile/components/background_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../constants.dart';

class SecuritySettingsState extends StatefulWidget {
  SecuritySettingsScreen createState() => SecuritySettingsScreen();
}

class SecuritySettingsScreen extends State<SecuritySettingsState> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);
  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];
  // ignore: non_constant_identifier_names
  String new_password;
  String oldPassword;
  UserModel u;
  @override
  Widget build(BuildContext context) {
    u = Provider.of<General_Provider>(context, listen: false).get_user();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        key: _scaffoldKey,
        appBar: AppBarPageName(
          pageName: "Change Password",
        ),
        body: BackgroundS(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(height: 15),
                ShadowBoxList(
                  color: Colors.white,
                  icon: Icon(
                    Icons.edit,
                    color: kPrimaryAccentColor,
                  ),
                  widgetColumn: <Widget>[
                    SizedBox(height: 10),
                    H2(textBody: "Account Password: *********"),
                    SizedBox(height: 5),
                    BodyText(
                        textBody: u == null
                            ? "Last Change: Loading..."
                            : "Full Name: " + u.lastPassChangeDate),
                    SizedBox(height: 5),
                    BodyText(textBody: "Tap to edit"),
                    SizedBox(height: 10),
                  ],
                  onTapFunction: () {
                    Alert(
                        context: context,
                        title: "Change Password",
                        closeIcon: Icon(
                          FontAwesomeIcons.timesCircle,
                          color: kPrimaryLightColor,
                        ),
                        style: AlertStyle(
                          overlayColor: Colors.black45,
                          titleStyle: H2TextStyle(color: kTextDarkColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            RoundedPasswordField(
                              onChanged: (value) => {this.oldPassword = value},
                              hintText: "Old Password",
                            ),
                            RoundedPasswordField(
                              onChanged: (value) => {this.new_password = value},
                              hintText: "New Password",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonErims(
                              onTap:
                                  (startLoading, stopLoading, btnState) async {
                                if (btnState == ButtonState.Idle) {
                                  startLoading();
                                  try {
                                    EmailAuthCredential credential =
                                        EmailAuthProvider.credential(
                                            email: u.email,
                                            password: oldPassword);
                                    await FirebaseAuth.instance.currentUser
                                        .reauthenticateWithCredential(
                                            credential);
                                    try {
                                      await changePassword(u, new_password)
                                          .then((value) => () {
                                                if (value == true) {
                                                  setState(() {
                                                    SnackBar sc = SnackBar(
                                                      content: Text(
                                                        "Password Changed Successfully",
                                                        style: H3TextStyle(),
                                                      ),
                                                    );
                                                    _scaffoldKey.currentState
                                                        .showSnackBar(sc);
                                                    Navigator.pop(context);
                                                    stopLoading();
                                                  });
                                                } else {
                                                  Alert(
                                                    context: context,
                                                    title:
                                                        "Something Went Wrong :(",
                                                    closeIcon: Icon(
                                                      FontAwesomeIcons
                                                          .timesCircle,
                                                      color: kPrimaryLightColor,
                                                    ),
                                                    style: AlertStyle(
                                                      overlayColor:
                                                          Colors.black45,
                                                      titleStyle: H2TextStyle(
                                                          color:
                                                              kTextDarkColor),
                                                    ),
                                                    content: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        H3(
                                                            textBody:
                                                                "Please enter correct old password."),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              });
                                    } catch (e) {
                                      print(e);
                                      Alert(
                                        context: context,
                                        title: "Something Went Wrong :(",
                                        closeIcon: Icon(
                                          FontAwesomeIcons.timesCircle,
                                          color: kPrimaryLightColor,
                                        ),
                                        style: AlertStyle(
                                          overlayColor: Colors.black45,
                                          titleStyle: H2TextStyle(
                                              color: kTextDarkColor),
                                        ),
                                        content: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            H3(
                                                textBody:
                                                    "Please enter correct old password."),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                    Alert(
                                      context: context,
                                      title: "Something Went Wrong :(",
                                      closeIcon: Icon(
                                        FontAwesomeIcons.timesCircle,
                                        color: kPrimaryLightColor,
                                      ),
                                      style: AlertStyle(
                                        overlayColor: Colors.black45,
                                        titleStyle:
                                            H2TextStyle(color: kTextDarkColor),
                                      ),
                                      content: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          H3(
                                              textBody:
                                                  "Please enter correct old password."),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  stopLoading();
                                }
                              },
                              labelText: "SAVE",
                            ),
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
                            onPressed: () {},
                          ),
                        ]).show();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/buttonErims.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/general_components/rounded_input_field.dart';
import 'package:calorie_mate/general_components/shadowBoxList.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/profile/components/background_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../constants.dart';

class AccountSettingScreen extends StatefulWidget {
  AccountSettingState createState() => AccountSettingState();
}

class AccountSettingState extends State<AccountSettingScreen> {
  String new_full_name;
  UserModel userObj;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);

  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];
  @override
  Widget build(BuildContext context) {
    userObj = Provider.of<General_Provider>(context, listen: false).get_user();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      key: _scaffoldKey,
      appBar: AppBarPageName(
        pageName: "Account Settings",
      ),
      body: BackgroundS(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ShadowBoxList(
                icon: Icon(Icons.edit, color: kIconColor),
                widgetColumn: <Widget>[
                  SizedBox(height: 10),
                  H2(textBody: userObj == null ? "Full Name: Loading..." : "Full Name: " + userObj.fullName),
                  SizedBox(height: 5),
                  BodyText(textBody: "Tap to edit"),
                  SizedBox(height: 10),
                ],
                onTapFunction: () {
                  Alert(
                      context: context,
                      title: "Change Full Name",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kTextDarkColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          RoundedInputField(
                            hintText: "New Full Name",
                            onChanged: (value) => {this.new_full_name = value},
                            icon: FontAwesomeIcons.solidUser,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonErims(
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                var retChangeFullName =
                                    changeFullName(userObj, new_full_name);
                                bool retChangeFullNameCheck;
                                await retChangeFullName.then(
                                    (value) => retChangeFullNameCheck = value);
                                if (retChangeFullNameCheck == true) {
                                  setState(() {
                                    userObj.fullName = new_full_name;
                                    Provider.of<General_Provider>(context,
                                            listen: false)
                                        .set_user(userObj);
                                    SnackBar sc = SnackBar(
                                      content: Text(
                                        "Full Name Changed Successfully",
                                        style: H3TextStyle(),
                                      ),
                                    );
                                    _scaffoldKey.currentState.showSnackBar(sc);
                                    Navigator.pop(context);
                                    stopLoading();
                                  });
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
    );
  }
}

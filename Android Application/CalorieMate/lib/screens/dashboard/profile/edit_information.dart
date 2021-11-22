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
import 'package:calorie_mate/screens/dashboard/dashboard.dart';
import 'package:calorie_mate/screens/dashboard/profile/components/background_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../constants.dart';

enum Gender { Male, Female, Other }
enum PhysicalActivityLevel { Sedentary, Light, Moderate, Vigorous }

extension ParseToString on Gender {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

extension ParseToString2 on PhysicalActivityLevel {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class EditInformation extends StatefulWidget {
  static final String id = '/EditProfile';
  @override
  _EditInformationState createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  String age;
  Gender _gender;
  String currentWeight;
  String targettedWeight;
  String heightFt;
  String heightIn;
  PhysicalActivityLevel _physicalActivityLevel;

  UserModel userObj;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);

  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];

  Future<bool> _onBackPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DashBoard()));
    true;
  }

  @override
  Widget build(BuildContext context) {
    userObj = Provider.of<General_Provider>(context, listen: false).get_user();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarPageName(
          pageName: "Edit Information",
          helpAlertTitle: "Edit Information Help",
          helpAlertBody: "View and edit profile information."),
      backgroundColor: kBackgroundColor,
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 10, right: 12, left: 12),
              child: Column(
                children: <Widget>[
                  //Edit Age
                  ShadowBoxList(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.calendarAlt, color: kCGBlue),
                    widgetColumn: <Widget>[
                      SizedBox(height: 10),
                      H2(
                          textBody: userObj.age == null
                              ? "Age: unset"
                              : "Age: " + (userObj.age).toString()),
                      SizedBox(height: 5),
                      BodyText(textBody: "Tap to update"),
                      SizedBox(height: 10),
                    ],
                    onTapFunction: () {
                      Alert(
                          context: context,
                          title: "Edit Age",
                          closeIcon: Icon(
                            FontAwesomeIcons.timesCircle,
                            color: kCGBlue,
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
                              RoundedInputField(
                                hintText: "Enter your age",
                                keyboardType: TextInputType.number,
                                onChanged: (value) => {this.age = value},
                                icon: FontAwesomeIcons.solidUser,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonErims(
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  if (btnState == ButtonState.Idle) {
                                    startLoading();
                                    var retChangeAge =
                                        changeAge(userObj, int.parse(age));
                                    bool retChangeAgeCheck;
                                    await retChangeAge.then(
                                        (value) => retChangeAgeCheck = value);
                                    if (retChangeAgeCheck == true) {
                                      setState(() {
                                        userObj.age = int.parse(age);
                                        Provider.of<General_Provider>(context,
                                                listen: false)
                                            .set_user(userObj);
                                        SnackBar sc = SnackBar(
                                          content: Text(
                                            "Age Edited Successfully",
                                            style: H3TextStyle(),
                                          ),
                                        );
                                        _scaffoldKey.currentState
                                            .showSnackBar(sc);
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
                  //Edit Gender
                  ShadowBoxList(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.venusMars, color: kCGBlue),
                    widgetColumn: <Widget>[
                      SizedBox(height: 10),
                      H2(
                          textBody: userObj.gender == null
                              ? "Gender: unset"
                              : "Gender: " + userObj.gender),
                      SizedBox(height: 5),
                      BodyText(textBody: "Tap to update"),
                      SizedBox(height: 10),
                    ],
                    onTapFunction: () {
                      Alert(
                          context: context,
                          title: "Edit Gender",
                          closeIcon: Icon(
                            FontAwesomeIcons.timesCircle,
                            color: kCGBlue,
                          ),
                          style: AlertStyle(
                            overlayColor: Colors.black45,
                            titleStyle: H2TextStyle(color: kTextDarkColor),
                          ),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio<Gender>(
                                        value: Gender.Male,
                                        groupValue: _gender,
                                        onChanged: (Gender value) {
                                          setState(() {
                                            _gender = value;
                                            print(_gender.toShortString());
                                          });
                                        },
                                      ),
                                      H3(textBody: "Male"),
                                      Radio<Gender>(
                                        value: Gender.Female,
                                        groupValue: _gender,
                                        onChanged: (Gender value) {
                                          setState(() {
                                            _gender = value;
                                            print(_gender.toShortString());
                                          });
                                        },
                                      ),
                                      H3(textBody: "Female"),
                                      Radio<Gender>(
                                        value: Gender.Other,
                                        groupValue: _gender,
                                        onChanged: (Gender value) {
                                          setState(() {
                                            _gender = value;
                                            print(_gender.toShortString());
                                          });
                                        },
                                      ),
                                      H3(textBody: "Other"),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          buttons: [
                            DialogButton(
                              color: kPrimaryAccentColor,
                              height: 40,
                              child: Text(
                                "SAVE",
                                style: TextStyle(color: kTextLightColor),
                              ),
                              onPressed: () async {
                                var retChangeGender = changeGender(
                                    userObj, _gender.toShortString());
                                bool retChangeGenderCheck;
                                await retChangeGender.then(
                                    (value) => retChangeGenderCheck = value);
                                if (retChangeGenderCheck == true) {
                                  setState(() {
                                    userObj.gender = _gender.toShortString();
                                    Provider.of<General_Provider>(context,
                                            listen: false)
                                        .set_user(userObj);
                                    SnackBar sc = SnackBar(
                                      content: Text(
                                        "Gender Edited Successfully",
                                        style: H3TextStyle(),
                                      ),
                                    );
                                    _scaffoldKey.currentState.showSnackBar(sc);
                                  });
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ]).show();
                    },
                  ),
                  //Edit Current Weight
                  ShadowBoxList(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.weight, color: kCGBlue),
                    widgetColumn: <Widget>[
                      SizedBox(height: 10),
                      H2(
                          textBody: userObj.currentWeight == null
                              ? "Current Weight: unset"
                              : "Current Weight: " +
                                  (userObj.currentWeight).toString() +
                                  " kg"),
                      SizedBox(height: 5),
                      BodyText(textBody: "Tap to update"),
                      SizedBox(height: 10),
                    ],
                    onTapFunction: () {
                      Alert(
                          context: context,
                          title: "Edit Current Weight (kg)",
                          closeIcon: Icon(
                            FontAwesomeIcons.timesCircle,
                            color: kCGBlue,
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
                              RoundedInputField(
                                hintText: "Enter your current weight",
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                onChanged: (value) =>
                                    {this.currentWeight = value},
                                icon: FontAwesomeIcons.solidUser,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonErims(
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  if (btnState == ButtonState.Idle) {
                                    startLoading();
                                    var retChangeCurrentWeight =
                                        changeCurrentWeight(userObj,
                                            double.parse(currentWeight));
                                    List<double> weightHist = [
                                      double.parse(currentWeight)
                                    ];
                                    var retUpdateWeightHistory =
                                        updateWeightHistory(
                                            userObj, weightHist);
                                    bool retChangeCurrentWeightCheck;
                                    bool retUpdateWeightHistoryCheck;
                                    await retChangeCurrentWeight.then((value) =>
                                        retChangeCurrentWeightCheck = value);
                                    await retUpdateWeightHistory.then((value) =>
                                        retUpdateWeightHistoryCheck = value);

                                    if (retChangeCurrentWeightCheck == true &&
                                        retUpdateWeightHistoryCheck == true) {
                                      setState(() {
                                        userObj.currentWeight =
                                            double.parse(currentWeight);
                                        Provider.of<General_Provider>(context,
                                                listen: false)
                                            .set_user(userObj);
                                        SnackBar sc = SnackBar(
                                          content: Text(
                                            "Current Weight Edited Successfully",
                                            style: H3TextStyle(),
                                          ),
                                        );
                                        _scaffoldKey.currentState
                                            .showSnackBar(sc);
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
                  //Edit Targetted Weight
                  ShadowBoxList(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.weight, color: kCGBlue),
                    widgetColumn: <Widget>[
                      SizedBox(height: 10),
                      H2(
                          textBody: userObj.targettedWeight == null
                              ? "Target Weight: unset"
                              : "Target Weight: " +
                                  (userObj.targettedWeight).toString() +
                                  " kg"),
                      SizedBox(height: 5),
                      BodyText(textBody: "Tap to update"),
                      SizedBox(height: 10),
                    ],
                    onTapFunction: () {
                      Alert(
                          context: context,
                          title: "Edit Targetted Weight (kg)",
                          closeIcon: Icon(
                            FontAwesomeIcons.timesCircle,
                            color: kCGBlue,
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
                              RoundedInputField(
                                hintText: "Enter your targetted weight",
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                onChanged: (value) =>
                                    {this.targettedWeight = value},
                                icon: FontAwesomeIcons.solidUser,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonErims(
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  if (btnState == ButtonState.Idle) {
                                    startLoading();
                                    var retChangeTargettedWeight =
                                        changeTargettedWeight(userObj,
                                            double.parse(targettedWeight));
                                    bool retChangeTargettedWeightCheck;
                                    await retChangeTargettedWeight.then(
                                        (value) =>
                                            retChangeTargettedWeightCheck =
                                                value);
                                    if (retChangeTargettedWeightCheck == true) {
                                      setState(() {
                                        userObj.targettedWeight =
                                            double.parse(targettedWeight);
                                        Provider.of<General_Provider>(context,
                                                listen: false)
                                            .set_user(userObj);
                                        SnackBar sc = SnackBar(
                                          content: Text(
                                            "Targetted Weight Edited Successfully",
                                            style: H3TextStyle(),
                                          ),
                                        );
                                        _scaffoldKey.currentState
                                            .showSnackBar(sc);
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
                  //Edit Height
                  ShadowBoxList(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.rulerVertical, color: kCGBlue),
                    widgetColumn: <Widget>[
                      SizedBox(height: 10),
                      H2(
                          textBody: userObj.heightFt == null
                              ? "Height: unset"
                              : "Height: " +
                                  (userObj.heightFt).toString() +
                                  "\' " +
                                  (userObj.heightIn).toString() +
                                  "\""),
                      SizedBox(height: 5),
                      BodyText(textBody: "Tap to update"),
                      SizedBox(height: 10),
                    ],
                    onTapFunction: () {
                      Alert(
                          context: context,
                          title: "Edit Height (Ft)",
                          closeIcon: Icon(
                            FontAwesomeIcons.timesCircle,
                            color: kCGBlue,
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
                              RoundedInputField(
                                hintText: "Feet",
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                onChanged: (value) => {this.heightFt = value},
                                icon: FontAwesomeIcons.solidUser,
                              ),
                              RoundedInputField(
                                hintText: "Inches",
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                onChanged: (value) => {this.heightIn = value},
                                icon: FontAwesomeIcons.solidUser,
                              ),
                              SizedBox(height: 10),
                              ButtonErims(
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  if (btnState == ButtonState.Idle) {
                                    startLoading();
                                    var retChangeHeight = changeHeight(
                                        userObj,
                                        int.parse(heightFt),
                                        int.parse(heightIn));
                                    bool retChangeHeightCheck;
                                    await retChangeHeight.then((value) =>
                                        retChangeHeightCheck = value);
                                    if (retChangeHeightCheck == true) {
                                      setState(() {
                                        userObj.heightFt = int.parse(heightFt);
                                        userObj.heightIn = int.parse(heightIn);
                                        Provider.of<General_Provider>(context,
                                                listen: false)
                                            .set_user(userObj);
                                        SnackBar sc = SnackBar(
                                          content: Text(
                                            "Height Edited Successfully",
                                            style: H3TextStyle(),
                                          ),
                                        );
                                        _scaffoldKey.currentState
                                            .showSnackBar(sc);
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
                  //Edit Physical Activity Level

                  ShadowBoxList(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.hiking, color: kCGBlue),
                    widgetColumn: <Widget>[
                      SizedBox(height: 10),
                      H2(
                          textBody: userObj.physicalActivityLevel == null
                              ? "Physical Activity Level: unset"
                              : "Physical Activity Level: " +
                                  userObj.physicalActivityLevel),
                      SizedBox(height: 5),
                      BodyText(textBody: "Tap to update"),
                      SizedBox(height: 10),
                    ],
                    onTapFunction: () async {
                      Alert(
                        context: context,
                        title: "Edit Physical Activity Level",
                        closeIcon: Icon(
                          FontAwesomeIcons.timesCircle,
                          color: kPrimaryLightColor,
                        ),
                        style: AlertStyle(
                          overlayColor: Colors.black45,
                          titleStyle: H2TextStyle(color: kTextDarkColor),
                        ),
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Radio<PhysicalActivityLevel>(
                                          value:
                                              PhysicalActivityLevel.Sedentary,
                                          groupValue: _physicalActivityLevel,
                                          onChanged:
                                              (PhysicalActivityLevel value) {
                                            setState(() {
                                              _physicalActivityLevel = value;
                                              print(_physicalActivityLevel
                                                  .toShortString());
                                            });
                                          },
                                        ),
                                        H3(textBody: "Sedentary"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<PhysicalActivityLevel>(
                                          value: PhysicalActivityLevel.Light,
                                          groupValue: _physicalActivityLevel,
                                          onChanged:
                                              (PhysicalActivityLevel value) {
                                            setState(() {
                                              _physicalActivityLevel = value;
                                              print(_physicalActivityLevel
                                                  .toShortString());
                                            });
                                          },
                                        ),
                                        H3(textBody: "Light"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<PhysicalActivityLevel>(
                                          value: PhysicalActivityLevel.Moderate,
                                          groupValue: _physicalActivityLevel,
                                          onChanged:
                                              (PhysicalActivityLevel value) {
                                            setState(() {
                                              _physicalActivityLevel = value;
                                              print(_physicalActivityLevel
                                                  .toShortString());
                                            });
                                          },
                                        ),
                                        H3(textBody: "Moderate"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<PhysicalActivityLevel>(
                                          value: PhysicalActivityLevel.Vigorous,
                                          groupValue: _physicalActivityLevel,
                                          onChanged:
                                              (PhysicalActivityLevel value) {
                                            setState(() {
                                              _physicalActivityLevel = value;
                                              print(_physicalActivityLevel
                                                  .toShortString());
                                            });
                                          },
                                        ),
                                        H3(textBody: "Vigorous"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        buttons: [
                          DialogButton(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            color: kCGBlue,
                            height: 40,
                            child: Text(
                              "SAVE",
                              style: TextStyle(color: kTextLightColor),
                            ),
                            onPressed: () async {
                              var retChangePhysicalActivityLevel =
                                  changePhysicalActivityLevel(userObj,
                                      _physicalActivityLevel.toShortString());
                              bool retChangePhysicalActivityLevelCheck;
                              await retChangePhysicalActivityLevel.then(
                                  (value) =>
                                      retChangePhysicalActivityLevelCheck =
                                          value);
                              if (retChangePhysicalActivityLevelCheck == true) {
                                setState(() {
                                  userObj.physicalActivityLevel =
                                      _physicalActivityLevel.toShortString();
                                  Provider.of<General_Provider>(context,
                                          listen: false)
                                      .set_user(userObj);
                                  SnackBar sc = SnackBar(
                                    content: Text(
                                      "Physical Activity Level Edited Successfully",
                                      style: H3TextStyle(),
                                    ),
                                  );
                                  _scaffoldKey.currentState.showSnackBar(sc);
                                });
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ).show();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

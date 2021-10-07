import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/buttonErims.dart';
import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/general_components/rounded_input_field.dart';
import 'package:calorie_mate/general_components/shadowBoxList.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../constants.dart';

class WeightTracker extends StatefulWidget {
  static final String id = '/WeightTracker';
  @override
  _WeightTrackerState createState() => _WeightTrackerState();
}

class _WeightTrackerState extends State<WeightTracker> {
  String currentWeight;
  String targettedWeight;

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
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBarPageName(
          pageName: "Weight Tracker",
          helpAlertTitle: "Weight Tracker Help",
          helpAlertBody: "Keep a track of your weight here."),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 32, right: 32, bottom: 36),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10, right: 20),
                height: 280,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: kPrimaryAccentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LineChart(
                  LineChartData(
                    backgroundColor: kPrimaryAccentColor,
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 250,
                    titlesData: LineTitles.getTitleData(),
                    lineTouchData: LineTouchData(enabled: true),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: kTextLightColor, width: 3),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.white30,
                          strokeWidth: 1,
                        );
                      },
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.white30,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        colors: [kPrimaryAccentColor, kTextLightColor],
                        spots: [
                          FlSpot(0, 180),
                          FlSpot(1, 140),
                          FlSpot(2, 110),
                          FlSpot(3, 150),
                          FlSpot(5, 105),
                          FlSpot(7, 90),
                          FlSpot(8, 80),
                          FlSpot(9, 95),
                          FlSpot(10, 75),
                          FlSpot(11, 60),
                        ],
                        belowBarData:
                            BarAreaData(show: true, colors: [Colors.white24]),
                        isCurved: true,
                        barWidth: 3,
                        colorStops: [0, 0],
                      ),
                    ],
                  ),
                ),
              ),
              //Current Weight
              ShadowBoxList(
                color: Colors.white,
                icon: Icon(FontAwesomeIcons.chartLine, color: kIconColor),
                widgetColumn: <Widget>[
                  SizedBox(height: 10),
                  H2(
                      textBody: userObj.currentWeight == null
                          ? "Desired Weight: unset"
                          : "Desired Weight: " +
                              (userObj.targettedWeight).toString() +
                              " kg"),
                  SizedBox(height: 5),
                  H2(
                      textBody: userObj.currentWeight == null
                          ? "Current Weight: unset"
                          : "Current Weight: " +
                              (userObj.currentWeight).toString() +
                              " kg"),
                  SizedBox(height: 10),
                ],
              ),
              //Add Updated Weight
              ShadowBoxList(
                color: Colors.white,
                icon: Icon(FontAwesomeIcons.plus, color: kIconColor),
                widgetColumn: <Widget>[
                  SizedBox(height: 20),
                  H2(
                    textBody: "Add Updated Weight",
                  ),
                  SizedBox(height: 20),
                ],
                onTapFunction: () {
                  Alert(
                      context: context,
                      title: "Edit Current Weight (kg)",
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
                          RoundedInputField(
                            hintText: "Enter your current weight",
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) => {this.currentWeight = value},
                            icon: FontAwesomeIcons.weight,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonErims(
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                var retChangeCurrentWeight =
                                    changeCurrentWeight(
                                        userObj, double.parse(currentWeight));
                                bool retChangeCurrentWeightCheck;
                                await retChangeCurrentWeight.then((value) =>
                                    retChangeCurrentWeightCheck = value);
                                if (retChangeCurrentWeightCheck == true) {
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

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          margin: 3,
          // reservedSize: 24,
          getTextStyles: (value) => const TextStyle(
            color: kTextLightColor,
            fontFamily: 'Montserrat',
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'FEB';
              case 3:
                return 'APR';
              case 5:
                return 'JUN';
              case 7:
                return 'AUG';
              case 9:
                return 'OCT';
              // case 11:
              //   return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          margin: 5,
          reservedSize: 30,
          getTextStyles: (value) => const TextStyle(
              color: kTextLightColor, fontFamily: 'Montserrat', fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 40:
                return '40';
              case 80:
                return '80';
              case 120:
                return '120';
              case 160:
                return '160';
              case 200:
                return '200';
              case 240:
                return '240';
            }
            return '';
          },
        ),
      );
}

import 'package:calorie_mate/general_components/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../constants.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();
    return Scaffold(
      appBar: AppBarPageName(
        pageName: "Diary",
        helpAlertTitle: "Diary Help",
        helpAlertBody:
            "Log daily calories either manually or using our calorie predictor.",
        leading: false,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.02),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: pageHeight * 0.2,
                  width: pageWidth,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(1.0, 1.0), //bottom right
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Today",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: pageWidth * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Goal",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "2000 kCal",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: kDarkAccentColor),
                                ),
                                SizedBox(height: pageHeight * 0.028),
                                Text(
                                  "Left",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "800 kCal",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkAccentColor,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularPercentIndicator(
                                  radius: pageHeight * 0.14,
                                  lineWidth: 10.0,
                                  percent: 0.7,
                                  animation: true,
                                  animationDuration: 1000,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  curve: Curves.ease,
                                  center: new Text("1200 kCal"),
                                  progressColor: kPrimaryGreenColor,
                                  backgroundColor: kAlphaGreenColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: pageHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  height: pageHeight * 0.13,
                  width: pageWidth,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(1.0, 1.0), //bottom right
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                "Breakfast",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkAccentColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "500 kCal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryGreenColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.3,
                        color: Colors.black38,
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: pageHeight * 0.042,
                            width: pageWidth * 0.3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                primary: kCGBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Add Food",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: pageHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  height: pageHeight * 0.13,
                  width: pageWidth,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(1.0, 1.0), //bottom right
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                "Lunch",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkAccentColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "400 kCal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryGreenColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.3,
                        color: Colors.black38,
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: pageHeight * 0.042,
                            width: pageWidth * 0.3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                primary: kCGBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Add Food",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: pageHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  height: pageHeight * 0.13,
                  width: pageWidth,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(1.0, 1.0), //bottom right
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                "Dinner",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkAccentColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "300 kCal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryGreenColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.3,
                        color: Colors.black38,
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: pageHeight * 0.042,
                            width: pageWidth * 0.3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                primary: kCGBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Add Food",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: pageHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  height: pageHeight * 0.13,
                  width: pageWidth,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(1.0, 1.0), //bottom right
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                "Snacks",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkAccentColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "0 kCal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryGreenColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.3,
                        color: Colors.black38,
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: pageHeight * 0.042,
                            width: pageWidth * 0.3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                primary: kCGBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Add Food",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/general_components/rounded_icon_button.dart';
import 'package:calorie_mate/models/diaryData.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/diary_firebase.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/tools/weight_tracker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  UserModel userObj;
  double caloriesBurnt;

  @override
  void initState() {
    super.initState();
    userObj = Provider.of<General_Provider>(context, listen: false).get_user();
    setState(() {
    caloriesBurnt = Provider.of<General_Provider>(context, listen: false).get_totalCaloriesBunrt();
    });
  }

  Stream taskDiary;
  Stream taskDiary2;
  Stream taskDiary3;
  Stream taskDiary4;
  Stream taskDiary5;
  Stream taskDiary6;
  Stream taskDiary7;

  List<DiaryData> diaryList = [];
  List<DiaryData> diaryList2 = [];
  List<DiaryData> diaryList3 = [];
  List<DiaryData> diaryList4 = [];
  List<DiaryData> diaryList5 = [];
  List<DiaryData> diaryList6 = [];
  List<DiaryData> diaryList7 = [];

  String calsConsumed;
  double calsConsumedDouble;

  String calsConsumed2;
  double calsConsumedDouble2;

  String calsConsumed3;
  double calsConsumedDouble3;

  String calsConsumed4;
  double calsConsumedDouble4;

  String calsConsumed5;
  double calsConsumedDouble5;

  String calsConsumed6;
  double calsConsumedDouble6;

  String calsConsumed7;
  double calsConsumedDouble7;

  DateTime date = DateTime.now();

  List<FlSpot> calsList = [];

  String countCalories(List<DiaryData> ls) {
    double caloriesToday = 0;

    if (ls.isNotEmpty) {
      for (int i = 0; i < ls.length; i++) {
        caloriesToday += double.parse(ls[i].calories);
      }
    }
    return caloriesToday.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();

    taskDiary =
        getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid, date);

    // diaryList = taskDiary.toList() as List<DiaryData>;

    taskDiary2 = getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid,
        date.subtract(Duration(days: 1)));

    taskDiary3 = getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid,
        date.subtract(Duration(days: 2)));

    taskDiary4 = getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid,
        date.subtract(Duration(days: 3)));

    taskDiary5 = getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid,
        date.subtract(Duration(days: 4)));

    taskDiary6 = getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid,
        date.subtract(Duration(days: 5)));

    taskDiary7 = getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid,
        date.subtract(Duration(days: 6)));

    return Scaffold(
      appBar: AppBarWithoutHome(
          pageName: "Statistics",
          helpAlertTitle: "Statistics Help",
          helpAlertBody:
              "View statistics to track progress of your fitness journey."),
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<Object>(
          stream: taskDiary,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              diaryList = snapshot.data;
              calsConsumed = countCalories(diaryList);
              calsConsumedDouble = double.parse(calsConsumed);
            }
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : StreamBuilder<Object>(
                    stream: taskDiary2,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        diaryList2 = snapshot.data;
                        calsConsumed2 = countCalories(diaryList2);
                        calsConsumedDouble2 = double.parse(calsConsumed2);
                      }
                      return !snapshot.hasData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : StreamBuilder<Object>(
                              stream: taskDiary3,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  diaryList3 = snapshot.data;
                                  calsConsumed3 = countCalories(diaryList3);
                                  calsConsumedDouble3 =
                                      double.parse(calsConsumed3);
                                }
                                return !snapshot.hasData
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : StreamBuilder<Object>(
                                        stream: taskDiary4,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            diaryList4 = snapshot.data;
                                            calsConsumed4 =
                                                countCalories(diaryList4);
                                            calsConsumedDouble4 =
                                                double.parse(calsConsumed4);
                                          }
                                          return !snapshot.hasData
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : StreamBuilder<Object>(
                                                  stream: taskDiary5,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      diaryList5 =
                                                          snapshot.data;
                                                      calsConsumed5 =
                                                          countCalories(
                                                              diaryList5);
                                                      calsConsumedDouble5 =
                                                          double.parse(
                                                              calsConsumed5);
                                                    }
                                                    return !snapshot.hasData
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : StreamBuilder<Object>(
                                                            stream: taskDiary6,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                diaryList6 =
                                                                    snapshot
                                                                        .data;
                                                                calsConsumed6 =
                                                                    countCalories(
                                                                        diaryList6);
                                                                calsConsumedDouble6 =
                                                                    double.parse(
                                                                        calsConsumed6);
                                                              }
                                                              return !snapshot
                                                                      .hasData
                                                                  ? Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    )
                                                                  : StreamBuilder<
                                                                          Object>(
                                                                      stream:
                                                                          taskDiary7,
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          diaryList7 =
                                                                              snapshot.data;
                                                                          calsConsumed7 =
                                                                              countCalories(diaryList7);
                                                                          calsConsumedDouble7 =
                                                                              double.parse(calsConsumed7);

                                                                          calsList =
                                                                              [];

                                                                          // calsList
                                                                          //     .clear();

                                                                          calsList.insert(
                                                                              0,
                                                                              FlSpot(0, calsConsumedDouble7));
                                                                          calsList.insert(
                                                                              1,
                                                                              FlSpot(1, calsConsumedDouble6));
                                                                          calsList.insert(
                                                                              2,
                                                                              FlSpot(2, calsConsumedDouble5));
                                                                          calsList.insert(
                                                                              3,
                                                                              FlSpot(3, calsConsumedDouble4));
                                                                          calsList.insert(
                                                                              4,
                                                                              FlSpot(4, calsConsumedDouble3));
                                                                          calsList.insert(
                                                                              5,
                                                                              FlSpot(5, calsConsumedDouble2));
                                                                          calsList.insert(
                                                                              6,
                                                                              FlSpot(6, calsConsumedDouble));

                                                                          // calsList.add(FlSpot(
                                                                          //     0,
                                                                          //     calsConsumedDouble7));
                                                                          // calsList.add(FlSpot(
                                                                          //     1,
                                                                          //     calsConsumedDouble6));
                                                                          // calsList.add(FlSpot(
                                                                          //     2,
                                                                          //     calsConsumedDouble5));
                                                                          // calsList.add(FlSpot(
                                                                          //     3,
                                                                          //     calsConsumedDouble4));
                                                                          // calsList.add(FlSpot(
                                                                          //     4,
                                                                          //     calsConsumedDouble3));
                                                                          // calsList.add(FlSpot(
                                                                          //     5,
                                                                          //     calsConsumedDouble2));
                                                                          // calsList.add(FlSpot(
                                                                          //     6,
                                                                          //     calsConsumedDouble));
                                                                        }
                                                                        return !snapshot.hasData
                                                                            ? Center(
                                                                                child: CircularProgressIndicator(),
                                                                              )
                                                                            : SafeArea(
                                                                                top: true,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                                                  child: Column(
                                                                                    children: <Widget>[
                                                                                      // Row(
                                                                                      //   children: <Widget>[
                                                                                      //     Text(
                                                                                      //       "Hello, " + userObj.fullName.split(" ").first + "! 👋",
                                                                                      //       style: TextStyle(
                                                                                      //         fontSize: 32,
                                                                                      //         fontFamily: "Quicksand-Bold",
                                                                                      //         fontWeight: FontWeight.bold,
                                                                                      //         color: kPrussianBlue,
                                                                                      //       ),
                                                                                      //     ),
                                                                                      //   ],
                                                                                      // ),
                                                                                      // SizedBox(height: 10),
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            padding: EdgeInsets.only(top: 10, bottom: 10, right: 0, left: 0),
                                                                                            height: pageHeight * 0.35,
                                                                                            width: pageWidth,
                                                                                            decoration: BoxDecoration(
                                                                                              color: kNavyBlue,
                                                                                              borderRadius: BorderRadius.only(
                                                                                                  bottomLeft: Radius.circular(20),
                                                                                                  // topLeft: Radius.circular(30),
                                                                                                  // topRight: Radius.circular(30),
                                                                                                  bottomRight: Radius.circular(20)),
                                                                                            ),
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: <Widget>[
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        "Weekly Calorie Intake",
                                                                                                        style: TextStyle(
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 22,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: pageWidth - 30,
                                                                                                  height: pageHeight * 0.26,
                                                                                                  padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 4),
                                                                                                  child: LineChart(
                                                                                                    LineChartData(
                                                                                                      backgroundColor: kNavyBlue,
                                                                                                      minX: 0,
                                                                                                      maxX: 6,
                                                                                                      minY: 0,
                                                                                                      maxY: 5500,
                                                                                                      titlesData: LineTitlesStats.getTitleData(),
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
                                                                                                          colors: [kCGBlue, kTextLightColor],
                                                                                                          spots: calsList,
                                                                                                          belowBarData: BarAreaData(show: true, colors: [Colors.white24]),
                                                                                                          isCurved: true,
                                                                                                          barWidth: 3,
                                                                                                          isStepLineChart: false,
                                                                                                          isStrokeCapRound: true,
                                                                                                          colorStops: [0, 0],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(height: 10),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            height: pageHeight * 0.216,
                                                                                            width: pageWidth * 0.44,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(30),
                                                                                              color: kViolet,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: <Widget>[
                                                                                                  CircleAvatar(
                                                                                                    backgroundColor: Colors.white24,
                                                                                                    maxRadius: 40,
                                                                                                    child:
                                                                                                        // Icon(
                                                                                                        //   FontAwesomeIcons.fire,
                                                                                                        //   color: Colors.white,
                                                                                                        //   size: 40,
                                                                                                        // ),
                                                                                                        SvgPicture.asset(
                                                                                                      "assets/svgs/bmi3.svg",
                                                                                                      width: 62,
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "BMI",
                                                                                                    style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    userObj.latestBMIScore.toStringAsFixed(1),
                                                                                                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            height: pageHeight * 0.216,
                                                                                            width: pageWidth * 0.44,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(30),
                                                                                              color: kRed,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: <Widget>[
                                                                                                  CircleAvatar(
                                                                                                    backgroundColor: Colors.white24,
                                                                                                    maxRadius: 40,
                                                                                                    child:
                                                                                                        // Icon(
                                                                                                        //   FontAwesomeIcons.fire,
                                                                                                        //   color: Colors.white,
                                                                                                        //   size: 40,
                                                                                                        // ),
                                                                                                        SvgPicture.asset(
                                                                                                      "assets/svgs/fire.svg",
                                                                                                      width: 44,
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Kcal Burnt",
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 22,
                                                                                                        color: Colors.white,
                                                                                                        // fontFamily: "Quicksand-Bold",
                                                                                                        fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  RichText(
                                                                                                    text: TextSpan(
                                                                                                      style: DefaultTextStyle.of(context).style,
                                                                                                      children: <TextSpan>[
                                                                                                        TextSpan(
                                                                                                          text: caloriesBurnt.toStringAsFixed(1),
                                                                                                          style: TextStyle(
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            color: Colors.white,
                                                                                                            fontSize: 28,
                                                                                                          ),
                                                                                                        ),
                                                                                                        TextSpan(
                                                                                                          text: ' Kcal',
                                                                                                          style: TextStyle(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            color: Colors.white,
                                                                                                            fontSize: 20,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(height: 10),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            height: pageHeight * 0.216,
                                                                                            width: pageWidth * 0.44,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(30),
                                                                                              color: kLightBlue,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: <Widget>[
                                                                                                  CircleAvatar(
                                                                                                    backgroundColor: Colors.white24,
                                                                                                    maxRadius: 40,
                                                                                                    child: SvgPicture.asset(
                                                                                                      "assets/svgs/weight3.svg",
                                                                                                      width: 42,
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Weight",
                                                                                                    style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  RichText(
                                                                                                    text: TextSpan(
                                                                                                      style: DefaultTextStyle.of(context).style,
                                                                                                      children: <TextSpan>[
                                                                                                        TextSpan(
                                                                                                          text: userObj.currentWeight.toStringAsFixed(1),
                                                                                                          style: TextStyle(
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            color: Colors.white,
                                                                                                            fontSize: 28,
                                                                                                          ),
                                                                                                        ),
                                                                                                        TextSpan(
                                                                                                          text: ' kg',
                                                                                                          style: TextStyle(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            color: Colors.white,
                                                                                                            fontSize: 22,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            height: pageHeight * 0.216,
                                                                                            width: pageWidth * 0.44,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(30),
                                                                                              color: kMustard,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: <Widget>[
                                                                                                  CircleAvatar(
                                                                                                    backgroundColor: Colors.white24,
                                                                                                    maxRadius: 40,
                                                                                                    child:
                                                                                                        // Icon(
                                                                                                        //   FontAwesomeIcons.fire,
                                                                                                        //   color: Colors.white,
                                                                                                        //   size: 40,
                                                                                                        // ),
                                                                                                        SvgPicture.asset(
                                                                                                      "assets/svgs/goal.svg",
                                                                                                      width: 48,
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Goal",
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 26,
                                                                                                        color: Colors.white,
                                                                                                        // fontFamily: "Quicksand-Bold",
                                                                                                        fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  RichText(
                                                                                                    text: TextSpan(
                                                                                                      style: DefaultTextStyle.of(context).style,
                                                                                                      children: <TextSpan>[
                                                                                                        TextSpan(
                                                                                                          text: userObj.targettedWeight.toStringAsFixed(1),
                                                                                                          style: TextStyle(
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            color: Colors.white,
                                                                                                            fontSize: 28,
                                                                                                          ),
                                                                                                        ),
                                                                                                        TextSpan(
                                                                                                          text: ' kg',
                                                                                                          style: TextStyle(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            color: Colors.white,
                                                                                                            fontSize: 22,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                      });
                                                            });
                                                  });
                                        });
                              });
                    });
          }),
    );
  }
}

class LineTitlesStats {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
          margin: 3,
          // reservedSize: 240,
          getTextStyles: (value) => const TextStyle(
            color: kTextLightColor,
            fontFamily: 'Quicksand',
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
          reservedSize: 40,
          getTextStyles: (value) => const TextStyle(
              color: kTextLightColor,
              fontFamily: 'Quicksand',
              fontSize: 13,
              fontWeight: FontWeight.bold),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';

              case 1000:
                return '1000';

              case 2000:
                return '2000';

              case 3000:
                return '3000';

              case 4000:
                return '4000';

              case 5000:
                return '5000';
            }
            return '';
          },
        ),
      );
}

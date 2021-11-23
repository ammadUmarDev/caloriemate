import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/models/diaryData.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/diary_firebase.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/diary/search_foods.dart';
import 'package:calorie_mate/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  UserModel user;
  String goal;
  int goalInt;
  String calsConsumedString;

  Stream taskDiary;
  List<DiaryData> diaryList = [];

  List<DiaryData> breakfastDiary = [];
  List<DiaryData> lunchDiary = [];
  List<DiaryData> dinnerDiary = [];
  List<DiaryData> snacksDiary = [];

  DateTime date = DateTime.now();
  String dateToDisplay;

  DateTime dateToday = DateTime.now();
  String dateTodayToDisplay;

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
  void initState() {
    super.initState();
    user = Provider.of<General_Provider>(context, listen: false).get_user();
    if (user == null) {
      print("user obj is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();
    user = Provider.of<General_Provider>(context, listen: false).get_user();

    goal = double.parse(user.bodyGoal).toStringAsFixed(0);
    goalInt = int.parse(goal);

    // dateToDisplay = convertDateTimeDisplay(date.toString());
    dateToDisplay = Utils().convertDateTimeDisplay(date.toString());
    dateTodayToDisplay = Utils().convertDateTimeDisplay(dateToday.toString());

    taskDiary =
        getDiaryLogsByUserToday(FirebaseAuth.instance.currentUser.uid, date);

    return Scaffold(
      appBar: AppBarPageName(
        pageName: "Diary",
        helpAlertTitle: "Diary Help",
        helpAlertBody:
            "Log daily calories either manually or using our calorie predictor.",
        leading: false,
      ),
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<Object>(
          stream: taskDiary,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            diaryList = snapshot.data;
            breakfastDiary = diaryList
                .where((element) => element.type == "breakfast")
                .toList();
            lunchDiary =
                diaryList.where((element) => element.type == "lunch").toList();
            dinnerDiary =
                diaryList.where((element) => element.type == "dinner").toList();
            snacksDiary =
                diaryList.where((element) => element.type == "snacks").toList();

            String calsConsumed = countCalories(diaryList);
            double calsConsumedDouble = double.parse(calsConsumed);

            String calsBreakfast = countCalories(breakfastDiary);
            String calsLunch = countCalories(lunchDiary);
            String calsDinner = countCalories(dinnerDiary);
            String calsSnacks = countCalories(snacksDiary);

            return SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      height: pageHeight * 0.242,
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
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: kNavyBlue,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Material(
                                  type: MaterialType.transparency,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(67.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        date = date
                                            .subtract(const Duration(days: 1));
                                      });
                                    },
                                    iconSize: 28,
                                    icon: Icon(
                                      Icons.arrow_back,
                                      // MaterialCommunityIcons.arrow_left_box,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                dateToDisplay == dateTodayToDisplay
                                    ? "Today"
                                    : dateToDisplay,
                                // "Today",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        date =
                                            date.add(const Duration(days: 1));
                                      });
                                    },
                                    iconSize: 28,
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: pageWidth * 0.05),
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      goal + " calories",
                                      // "2000 calories",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        // color: kPrimaryGreenColor,
                                      ),
                                    ),
                                    SizedBox(height: pageHeight * 0.04),
                                    Text(
                                      "Left",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      (goalInt - calsConsumedDouble)
                                              .toStringAsFixed(0) +
                                          " calories",
                                      // "800 kCal",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        // color: kPrimaryGreenColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircularPercentIndicator(
                                      radius: pageHeight * 0.16,
                                      lineWidth: 11.0,
                                      percent:
                                          (calsConsumedDouble / goalInt) >= 1
                                              ? 1.0
                                              : calsConsumedDouble / goalInt,
                                      animation: true,
                                      animationDuration: 1000,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      curve: Curves.ease,
                                      center: new Text(
                                        calsConsumed + " kCal",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      progressColor:
                                          (calsConsumedDouble / goalInt) >= 1
                                              ? kActiveCardColour
                                              : kYellow,
                                      backgroundColor: kYellow.withAlpha(110),
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
                      margin: EdgeInsets.only(top: pageHeight * 0.02),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      // height: pageHeight * 0.13,
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
                                      color: kNavyBlue,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    calsBreakfast + " kCal",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kCGBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // SizedBox(height: 4),
                          Divider(
                            thickness: 0.5,
                            height: 10,
                            color: Colors.black45,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: breakfastDiary.length,
                            itemBuilder: (context, index) {
                              return _listItem(index, breakfastDiary);
                            },
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: pageHeight * 0.042,
                                width: pageWidth * 0.32,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    primary: kYellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "ADD FOOD",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SearchFoods(
                                          type: "breakfast",
                                          date: date,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: pageHeight * 0.02),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      // height: pageHeight * 0.13,
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
                                      color: kNavyBlue,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    calsLunch + " kCal",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kCGBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                            height: 10,
                            color: Colors.black45,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: lunchDiary.length,
                            itemBuilder: (context, index) {
                              return _listItem(index, lunchDiary);
                            },
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: pageHeight * 0.042,
                                width: pageWidth * 0.32,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    primary: kYellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "ADD FOOD",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SearchFoods(
                                          type: "lunch",
                                          date: date,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: pageHeight * 0.02),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      // height: pageHeight * 0.13,
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
                                      color: kNavyBlue,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    calsDinner + " kCal",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kCGBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.black45,
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dinnerDiary.length,
                            itemBuilder: (context, index) {
                              return _listItem(index, dinnerDiary);
                            },
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: pageHeight * 0.042,
                                width: pageWidth * 0.32,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    primary: kYellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "ADD FOOD",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SearchFoods(
                                          type: "dinner",
                                          date: date,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: pageHeight * 0.02),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      // height: pageHeight * 0.13,
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
                                      color: kNavyBlue,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    calsSnacks + " kCal",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kCGBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.black45,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snacksDiary.length,
                            itemBuilder: (context, index) {
                              return _listItem(index, snacksDiary);
                            },
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: pageHeight * 0.042,
                                width: pageWidth * 0.32,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    primary: kYellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "ADD FOOD",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SearchFoods(
                                          type: "snacks",
                                          date: date,
                                        ),
                                      ),
                                    );
                                  },
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
            );
          }),
    );
  }

  Widget _listItem(int index, List<DiaryData> ls) {
    return Card(
        color: kPrimaryGreenColor,
        elevation: 2.5,
        margin: EdgeInsets.only(bottom: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: InkWell(
          onTap: () {
            Alert(
              // type: AlertType.none,
              context: context,
              title: "Delete Item?",
              image: SvgPicture.asset("assets/svgs/delete.svg",
                  height: 72, width: 72),
              closeIcon: Icon(
                FontAwesomeIcons.timesCircle,
                color: kPrimaryLightColor,
              ),
              desc: ls[index].name +
                  "\n" +
                  double.parse(ls[index].amount).toStringAsFixed(2) +
                  " " +
                  ls[index].portionName +
                  "\n" +
                  double.parse(ls[index].calories).toStringAsFixed(0) +
                  " calories",
              style: AlertStyle(
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  descStyle: TextStyle(fontSize: 15),
                  overlayColor: Colors.black45,
                  alertAlignment: Alignment.bottomCenter),
              buttons: [
                DialogButton(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: kActiveCardColour,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "DELETE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {
                    deleteLog(ls[index].id);
                    Navigator.pop(context);
                  },
                ),
              ],
            ).show();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ls[index].name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      double.parse(ls[index].calories).toStringAsFixed(0) +
                          " kCal",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

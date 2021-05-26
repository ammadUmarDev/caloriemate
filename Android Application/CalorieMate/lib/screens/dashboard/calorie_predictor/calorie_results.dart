import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/models/calories_data.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_predictor.dart';
import 'package:flutter/material.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CalorieResults extends StatefulWidget {
  static final String id = '/CalorieResults';

  int predictedCalories;
  int predictedQuantity;

  CalorieResults({
    // Key key,
    this.predictedCalories,
    this.predictedQuantity,
  });
  // : super(key: key);

  @override
  _CalorieResultsState createState() =>
      _CalorieResultsState(predictedCalories, predictedQuantity);
}

class _CalorieResultsState extends State<CalorieResults> {
  int calories;
  int quantity;

  _CalorieResultsState(this.calories, this.quantity);

  @override
  void initState() {
    super.initState();
    calories = widget.predictedCalories;
    print(widget.predictedCalories);
    print(calories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
          pageName: "Calorie Predictor",
          helpAlertTitle: "Calorie Predictor Results Help",
          helpAlertBody: "These are the results of the food item you "),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  height: 375,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        H1(
                          textBody: "Results",
                          color: kPrimaryDarkColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: kPrimaryAccentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            MaterialCommunityIcons.chart_areaspline,
                            size: 90,
                            color: kTextLightColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            H2(
                              textBody: "Estimated Energy: ",
                              color: kPrimaryDarkColor,
                            ),
                            H2(
                              textBody: "$calories Kcal",
                              color: kTextDarkColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            H2(
                              textBody: "Estimated Serving Size: ",
                              color: kPrimaryDarkColor,
                            ),
                            H2(
                              textBody: "$quantity g",
                              color: kTextDarkColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                Alert(
                                  context: context,
                                  title: "Coming Soon",
                                  style: AlertStyle(
                                    titleStyle:
                                        H2TextStyle(color: kPrimaryAccentColor),
                                  ),
                                  content: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      H3(
                                          textBody:
                                              "Stay tuned for the next update :)"),
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
                                  ],
                                ).show();
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.add_circle_outline_outlined,
                                    color: kIconColor,
                                    size: 38,
                                  ),
                                  H3(
                                    textBody: "Add to Diary",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CaloriePredictorScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.repeat,
                                    size: 38,
                                    color: kIconColor,
                                  ),
                                  H3(
                                    textBody: "Retry",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

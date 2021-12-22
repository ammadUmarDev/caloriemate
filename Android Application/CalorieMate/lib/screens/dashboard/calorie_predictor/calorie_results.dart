import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/models/calories_data.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_predictor.dart';
import 'package:flutter/material.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CalorieResults extends StatefulWidget {
  static final String id = '/CalorieResults';


  String predictedName;
  double predictedWeight;
  double predictedCalories;
  String error;

  CalorieResults({
    // Key key,
    this.predictedName,
    this.predictedWeight,
    this.predictedCalories,
    this.error,
  });
  // : super(key: key);

  @override
  _CalorieResultsState createState() =>_CalorieResultsState();
}

class _CalorieResultsState extends State<CalorieResults> {

  @override
  void initState() {
    super.initState();
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            H1(
                              textBody: "Predicted Item Type: ",
                              color: kPrimaryDarkColor,
                            ),
                            H1(
                              textBody: widget.predictedName,
                              color: kTextDarkColor,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            H1(
                              textBody: "Predicted Weight: ",
                              color: kPrimaryDarkColor,
                            ),
                            H1(
                              textBody: widget.predictedWeight.toStringAsFixed(1),
                              color: kTextDarkColor,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            H1(
                              textBody: "Estimated Energy: ",
                              color: kPrimaryDarkColor,
                            ),
                            H1(
                              textBody: widget.predictedCalories.toStringAsFixed(1) +" Kcal",
                              color: kTextDarkColor,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            H2(
                              textBody: widget.error,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
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

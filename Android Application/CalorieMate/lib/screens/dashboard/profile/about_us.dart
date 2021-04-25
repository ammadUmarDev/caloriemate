import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/h1.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              kPrimaryAccentColor,
              kPrimaryLightColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "CalorieMate",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 40.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Fitness Advisor",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: ListView(
                    children: <Widget>[
                      H1(textBody: "Get to know us"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Welcome to TripleA®. We provide intelligent solutions to unlock new possibilities. Together, we can bring your ideas to life so reach out for a new project."),
                      SizedBox(height: 15),
                      H1(textBody: "What is CalorieMate ® ?"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "CalorieMate is a lifestyle cross-platform app spanning on both food and fitness offering a new way of living a healthy lifestyle. It does so using machine learning/deep learning techniques to predict the daily calorie intake along with the serving size/quantity of fast-food by taking a picture of the meal. The application further maintains a diary, provides meal and training trackers and recommends calorie intake to reach a weight goal relative to each user's profile."),
                      SizedBox(height: 15),
                      H1(textBody: "Contact us"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Reach out to TripleA® at TripleA.contact@gmail.com"),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

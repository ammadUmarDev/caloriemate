import 'dart:convert';

import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/text_Field_outlined.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/models/workout.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import 'models/workoutItems.dart';

class WorkoutRecommender extends StatefulWidget {
  static final String id = '/WorkoutRecommender';

  @override
  _WorkoutRecommenderState createState() => _WorkoutRecommenderState();
}

class _WorkoutRecommenderState extends State<WorkoutRecommender> {
  UserModel user;
  int goal;
  //final List<Workout> workouts = List.from(workoutItems);
  final listKey = GlobalKey<AnimatedListState>();
  Expanded workoutRecommendationsList;
  bool showRecommendationList = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<General_Provider>(context, listen: false).get_user();
    if (user == null) {
      print("user obj is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
          pageName: "Workout Recommender",
          helpAlertTitle: "Workout Recommender Help",
          helpAlertBody: "Get your workout recommendations here."),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 32, right: 32, bottom: 0),
          child: Column(
            children: <Widget>[
              bodyGoalTextField,
              SizedBox(height: 16),
              SizedBox(
                height: 52,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: kYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Get Random Recommendation",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onPressed: () async {
                    if (bodyGoalTextField.getReturnValue() != null) {
                      goal = int.parse(bodyGoalTextField.getReturnValue());
                      final response = await http.get(Uri.parse('http://2498-34-125-20-125.ngrok.io/generateRandomWorkouts'));
                      final parsed = json.decode(response.body);
                      final results = parsed["results"];
                      List<Workout> workouts = [];
                      for (var i = 0; i < results.length; i++) {
                        workouts.add(Workout.fromJson(results[i]));
                      }
                      //final workouts = Workout.fromJson(parsedJson);
                      print (workouts);
                      setState(() {
                        workoutRecommendationsList =
                            buildWorkoutRecommendations(context, workouts);
                        showRecommendationList = true;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 16),
              if (showRecommendationList) workoutRecommendationsList
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWorkoutRecommendations(BuildContext context, List<Workout> ls) {
    return Expanded(
      child: AnimatedList(
        key: listKey,
        initialItemCount: ls.length,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: Container(
                height: 132,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      offset: Offset(1.0, 1.0),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.5, horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: kYellow,
                            maxRadius: 25,
                            child: ClipOval(
                              child: SvgPicture.asset("assets/svgs/dumbell.svg",
                                  width: 40),
                              // Image.asset(
                              //   "assets/images/dumbell.png",
                              //   width: 50,
                              // ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 136,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                ls[index].exercise,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kNavyBlue,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Burns: " + (ls[index].burnKg*user.currentWeight).round().toString() + " calories",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          Text(
                            "60 mins",
                            style: TextStyle(
                                color: kNavyBlue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Minutes",
                            style: TextStyle(fontSize: 13),
                          ),
                          Spacer(),
                          Text(
                            "1",
                            style: TextStyle(
                                color: kNavyBlue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Reps",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  TextFieldOutlined bodyGoalTextField = TextFieldOutlined(
    textFieldText: 'Body Goal(kg)',
    textFieldIcon: SvgPicture.asset(
      "assets/svgs/target.svg",
      width: 20,
    ),
    // Icon(
    //   MaterialCommunityIcons.bullseye_arrow,
    //   size: 22,
    //   color: kIconColor,
    // ),
    keyboardType: TextInputType.number,
    isValidEntry: (entry) {
      if (entry.toString().isEmpty &&
          entry.toString().startsWith(' ') &&
          entry.toString().endsWith(' ') &&
          entry.toString().contains(' ') == false) {
        return null;
      }
      return '';
    },
  );
}

import 'dart:convert';

import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/text_Field_outlined.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/models/workout.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import 'models/workoutPlanned.dart';
import 'models/workoutItems.dart';

class WorkoutRecommender extends StatefulWidget {
  static final String id = '/WorkoutRecommender';

  @override
  _WorkoutRecommenderState createState() => _WorkoutRecommenderState();
}

class _WorkoutRecommenderState extends State<WorkoutRecommender> {
  UserModel user;
  int goal;
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  //final List<Workout> workouts = List.from(workoutItems);
  final listKey = GlobalKey<AnimatedListState>();
  Expanded workoutRecommendationsList;
  bool showRecommendationList = false;
  bool enableGetRecommendation = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkoutRecommenderSeverURL(context);
    getCaloriePredictorSeverURL(context);
    _myActivities = [];
    _myActivitiesResult = '';
    user = Provider.of<General_Provider>(context, listen: false).get_user();
    if (user == null) {
      print("user obj is null");
    }
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
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
              Container(
                padding: EdgeInsets.all(5),
                child: MultiSelectFormField(
                  autovalidate: true,
                  chipBackGroundColor: Colors.blue,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blue,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Select Completed Workouts",
                    style: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.length != 5) {
                      // setState(() {
                      //   enableGetRecommendation = false;
                      // });
                      return 'Please select 5 completed workouts to \nEnable Get Recommendation';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "Walking 5.0 mph",
                      "value": "174",
                    },
                    {
                      "display": "Marching, rapidly, military",
                      "value": "158",
                    },
                    {
                      "display": "Sailing, competition	",
                      "value": "184",
                    },
                    {
                      "display": "Table tennis, ping pong",
                      "value": "130",
                    },
                    {
                      "display": "Aerobics, low impact	",
                      "value": "25",
                    },
                    {
                      "display": "Playing racquetball	",
                      "value": "112",
                    },
                    {
                      "display": "Jumping rope, slow",
                      "value": "117",
                    },
                    {
                      "display": "Stationary cycling, moderate",
                      "value": "10",
                    },
                    {
                      "display": "Running, general",
                      "value": "49",
                    },
                    {
                      "display": "Pushing a cart",
                      "value": "161",
                    },
                    {
                      "display": "Whitewater rafting, kayaking, canoeing",
                      "value": "193",
                    },
                    {
                      "display": "Carrying 5kg upstairs",
                      "value": "143",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose five'),
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                      if (value.length != 5)
                        enableGetRecommendation = false;
                      else
                        enableGetRecommendation = true;
                    });
                  },
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(8),
              //   child: ElevatedButton(
              //     child: Text('Save'),
              //     onPressed: _saveForm,
              //   ),
              // ),
              SizedBox(height: 16),
              SizedBox(
                height: 52,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: (enableGetRecommendation && _myActivities.length != 0? kYellow : Colors.black26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Get Recommendation",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onPressed: () async {
                    if (enableGetRecommendation && _myActivities.length != 0) {
                      final serverURL = Provider.of<General_Provider>(context, listen: false).get_workoutRecommenderSeverURL();
                      print(serverURL.toString()+'/generateRecommendWorkouts');
                      final response = await http.post(Uri.parse(serverURL.toString()+'/generateRecommendWorkouts'),
                          body:jsonEncode(<String, String>{
                            'ids': _myActivities.toString(),
                          }));
                      final parsed = json.decode(response.body);
                      final results = parsed["results"];
                      List<Workout> workouts = [];
                      List<WorkoutPlanned> workoutsPlanned = [];
                      UserModel u = Provider.of<General_Provider>(context, listen: false).get_user();
                      double sumBurnt = 0;
                      for (var i = 0; i < results.length; i++) {
                        Workout workoutObj = Workout.fromJson(results[i]);
                        workouts.add(Workout.fromJson(results[i]));
                        workoutsPlanned.add(WorkoutPlanned(workoutObj.exercise,DateTime.now(),(workoutObj.burnKg*u.currentWeight).toStringAsFixed(1), "60", "1", false));
                        sumBurnt += (workoutObj.burnKg*u.currentWeight);
                      }
                      Provider.of<General_Provider>(context, listen: false).set_workoutsPlanned(workoutsPlanned);
                      Provider.of<General_Provider>(context, listen: false).set_totalCaloriesBunrt(sumBurnt);
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
              SizedBox(
                height: 52,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: (_myActivities.length == 0? kYellow : Colors.black26),
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
                    if (_myActivities.length == 0) {
                      final serverURL = Provider.of<General_Provider>(context, listen: false).get_workoutRecommenderSeverURL();
                      print(serverURL.toString()+'/generateRandomWorkouts');
                      final response = await http.get(Uri.parse(serverURL.toString()+'/generateRandomWorkouts'));
                      final parsed = json.decode(response.body);
                      final results = parsed["results"];
                      print(results);
                      List<Workout> workouts = [];
                      List<WorkoutPlanned> workoutsPlanned = [];
                      UserModel u = Provider.of<General_Provider>(context, listen: false).get_user();
                      double sumBurnt = 0;
                      for (var i = 0; i < results.length; i++) {
                        Workout workoutObj = Workout.fromJson(results[i]);
                        workouts.add(workoutObj);
                        workoutsPlanned.add(WorkoutPlanned(workoutObj.exercise,DateTime.now(),(workoutObj.burnKg*u.currentWeight).toStringAsFixed(1), "60", "1", false));
                        sumBurnt += (workoutObj.burnKg*u.currentWeight);
                      }
                      Provider.of<General_Provider>(context, listen: false).set_workoutsPlanned(workoutsPlanned);
                      Provider.of<General_Provider>(context, listen: false).set_totalCaloriesBunrt(sumBurnt);
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
                            "60",
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

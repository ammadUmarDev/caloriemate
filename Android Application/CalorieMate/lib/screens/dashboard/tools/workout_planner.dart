import 'package:auto_size_text/auto_size_text.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants.dart';
import 'models/workout.dart';
import 'models/workoutItems.dart';

class WorkoutPlanner extends StatefulWidget {
  static final String id = '/WorkoutPlanner';

  @override
  _WorkoutPlannerState createState() => _WorkoutPlannerState();
}

class _WorkoutPlannerState extends State<WorkoutPlanner> {
  final List<Workout> items = List.from(workoutItems);
  final listKey = GlobalKey<AnimatedListState>();

  // void removeItem(int index) {
  //   final removedItem = items[index];

  //   items.removeAt(index);
  //   listKey.currentState.removeItem(
  //       index,
  //       (context, animation) => WorkoutItemWidget(
  //           item: removedItem, animation: animation, onClicked: () {}));
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarPageName(
            pageName: "Workout Planner",
            helpAlertTitle: "Workout Planner Help",
            helpAlertBody: "Plan your workouts here."),
        backgroundColor: kBackgroundColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            child: Icon(
              MaterialIcons.add,
              color: kNavyBlue,
              size: 40,
            ),
            elevation: 3,
            backgroundColor: kYellow,
            onPressed: () {},
          ),
        ),
        body: SafeArea(
          top: true,
          child: AnimatedList(
            key: listKey,
            initialItemCount: workoutItems.length,
            itemBuilder: (context, index, animation) {
              return GestureDetector(
                onTap: () {
                  print("======kkklll====");
                  Alert(
                    type: AlertType.none,
                    context: context,
                    title: "Mark as complete?",
                    closeIcon: Icon(
                      FontAwesomeIcons.timesCircle,
                      color: kPrimaryLightColor,
                    ),
                    style: AlertStyle(
                        overlayColor: Colors.black45,
                        alertAlignment: Alignment.bottomCenter),
                    buttons: [
                      DialogButton(
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        color: kYellow,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "DONE",
                              style: TextStyle(
                                  color: kNavyBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              MaterialIcons.check_circle,
                              color: kNavyBlue,
                            ),
                          ],
                        ),
                        onPressed: () {
                          items.removeAt(index);
                          listKey.currentState
                              .removeItem(index, (context, animation) => null);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ).show();
                },
                child: SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(animation),
                  child: Container(
                      height: 132,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: kYellow,
                                  maxRadius: 28,
                                  child: ClipOval(
                                    child: SvgPicture.asset(
                                        "assets/svgs/dumbell.svg",
                                        width: 44),
                                    // Image.asset(
                                    //   "assets/images/dumbell.png",
                                    //   width: 40,
                                    // ),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 136,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      items[index].name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kNavyBlue,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  items[index].status == false
                                      ? "Status: Incomplete"
                                      : "Status: Complete",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: <Widget>[
                                Text(
                                  items[index].duration,
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
                                  items[index].reps,
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
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset("assets/svgs/medal.svg",
                                        width: 26),
                                    // Icon(
                                    //   FontAwesomeIcons.award,
                                    //   color: kPrimaryAccentColor,
                                    // ),
                                    SizedBox(width: 4),

                                    Text(
                                      items[index].calories + "Kcal",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    // Text(data),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset("assets/svgs/clock.svg",
                                        width: 26),
                                    // Icon(
                                    //   MaterialIcons.schedule,
                                    //   color: kPrimaryAccentColor,
                                    // ),
                                    SizedBox(width: 4),
                                    Text(
                                      items[index].dateTime.hour.toString() +
                                          ":" +
                                          items[index]
                                              .dateTime
                                              .minute
                                              .toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      items[index].dateTime.hour > 11
                                          ? " pm"
                                          : "am",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset("assets/svgs/calendar.svg",
                                        width: 24),
                                    // Icon(
                                    //   MaterialIcons.today,
                                    //   color: kPrimaryAccentColor,
                                    // ),
                                    SizedBox(width: 4),
                                    Text(
                                      items[index].dateTime.day.toString() +
                                          "/" +
                                          items[index]
                                              .dateTime
                                              .month
                                              .toString() +
                                          "/" +
                                          items[index].dateTime.year.toString(),
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
        ),
      );
}

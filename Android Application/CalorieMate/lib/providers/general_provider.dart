import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/screens/dashboard/tools/models/workoutPlanned.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class General_Provider extends ChangeNotifier {
  UserModel user;
  User firebaseUser;
  String workoutRecommenderSeverURL;
  String caloriePredictorSeverURL;
  List<WorkoutPlanned> workoutsPlanned;

  UserModel get_user() {
    if (user == null) {
      print("User has not been set yet");
    }
    return user;
  }

  void set_user(UserModel u) {
    this.user = u;
  }

  User get_firebase_user() {
    if (firebaseUser == null) {
      print("Firebase user has not been set yet");
    }
    return firebaseUser;
  }

  void set_firebase_user(User u) {
    this.firebaseUser = u;
  }

  String get_workoutRecommenderSeverURL() {
    if (workoutRecommenderSeverURL == null) {
      print("workoutRecommenderSeverURL has not been set yet");
    }
    return workoutRecommenderSeverURL;
  }

  void set_workoutRecommenderSeverURL(String workoutRecommenderSeverURL) {
    this.workoutRecommenderSeverURL = workoutRecommenderSeverURL;
  }

  String get_caloriePredictorSeverURL() {
    if (caloriePredictorSeverURL == null) {
      print("caloriePredictorSeverURL has not been set yet");
    }
    return caloriePredictorSeverURL;
  }

  void set_caloriePredictorSeverURL(String caloriePredictorSeverURL) {
    this.caloriePredictorSeverURL = caloriePredictorSeverURL;
  }

  // ignore: non_constant_identifier_names
  List<WorkoutPlanned> get_workoutsPlanned() {
    if (workoutsPlanned == null) {
      print("workoutsRecommended has not been set yet");
    }
    return workoutsPlanned;
  }

  void set_workoutsPlanned(List<WorkoutPlanned> workoutsPlanned) {
    this.workoutsPlanned = workoutsPlanned;
  }
}

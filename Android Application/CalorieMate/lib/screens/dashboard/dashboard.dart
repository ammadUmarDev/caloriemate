import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_predictor.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/loading.dart';
import 'package:calorie_mate/screens/dashboard/diary/diary.dart';
import 'package:calorie_mate/screens/dashboard/profile/profile.dart';
import 'package:calorie_mate/screens/dashboard/statistics/statistics.dart';
import 'package:calorie_mate/screens/dashboard/tools/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class DashBoard extends StatefulWidget {
  final int pageNumber;

  const DashBoard({
    Key key,
    @required this.pageNumber,
  }) : super(key: key);

  static final String id = '/DashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController pageController;
  int pageIndex;

  User signInUser = FirebaseAuth.instance.currentUser;

  int feetToCm(int ft, int inches) {
    int height;
    int inchesTotal = (ft * 12) + inches;
    height = (inchesTotal * 2.54).toInt();
    print(height);
    return height;
  }

  String calculateBMR(
      String gender, double weight, int height, int age, String activityLevel) {
    double bmr;
    if (gender == "Male") {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    }

    if (gender == "Female") {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    if (activityLevel == "Sedentary") {
      bmr = bmr * 0.9;
    }

    if (activityLevel == "Light") {
      bmr = bmr * 1.1;
    }

    if (activityLevel == "Moderate") {
      bmr = bmr * 1.3;
    }

    if (activityLevel == "Vigorous") {
      bmr = bmr * 1.5;
    }

    return bmr.toStringAsFixed(1);
  }

  Future<void> getUserInfo() async {
    int ft;
    int inches;
    double weight;
    int age;
    int height;
    String bodyGoal;
    String gender;
    String activityLevel;

    if (signInUser != null) {
      final currentUserId = signInUser.uid;
      print(currentUserId);
      UserModel retGetUserObjFirebase;
      //TODO: This function below returns null and provider is unable to save obj
      FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference users = db.collection('Users');
      await users
          .doc(currentUserId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document exist on the database');
          retGetUserObjFirebase = UserModel(
            email: documentSnapshot.data()["Email"].toString(),
            fullName: documentSnapshot.data()["Full_Name"].toString(),
            userID: documentSnapshot.data()["User_Id"].toString(),
            phoneNumber: documentSnapshot.data()["Phone_Number"].toString(),
            age: documentSnapshot.data()["Age"],
            gender: documentSnapshot.data()["Gender"].toString(),
            currentWeight: documentSnapshot.data()["Current_Weight"],
            targettedWeight: documentSnapshot.data()["Targetted_Weight"],
            heightFt: documentSnapshot.data()["Height_Ft"],
            heightIn: documentSnapshot.data()["Height_In"],
            bodyGoal: documentSnapshot.data()["Body_Goal"],
            physicalActivityLevel:
                documentSnapshot.data()["Physical_Activity_Level"].toString(),
            createdDate: documentSnapshot.data()["Created_Date"].toString(),
            lastPassChangeDate:
                documentSnapshot.data()["Last_Pass_Change_Date"].toString(),
          );
        }
      });
      if (retGetUserObjFirebase != null) {
        try {
          ft = retGetUserObjFirebase.heightFt;
          inches = retGetUserObjFirebase.heightIn;
          age = retGetUserObjFirebase.age;
          weight = retGetUserObjFirebase.currentWeight;
          gender = retGetUserObjFirebase.gender;
          activityLevel = retGetUserObjFirebase.physicalActivityLevel;

          if (gender != null &&
              weight != null &&
              age != null &&
              ft != null &&
              inches != null) {
            setState(() {
              height = feetToCm(ft, inches);
              bodyGoal =
                  calculateBMR(gender, weight, height, age, activityLevel);
              retGetUserObjFirebase.bodyGoal = bodyGoal;
              updateBodyGoal(retGetUserObjFirebase, bodyGoal);
            });
          }

          print("dsdsad" + retGetUserObjFirebase.userID);
          Provider.of<General_Provider>(context, listen: false)
              .set_user(retGetUserObjFirebase);
          try {
            Provider.of<General_Provider>(context, listen: false)
                .set_firebase_user(signInUser);
            print("User Signed In, Proceeding to Dashboard");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
          // stopLoading();
        } catch (e) {
          print(e);
        }
      } else {
        print("retGetUserDocFirebase is null");
      }
    }
  }

  @override
  Future<void> initState() {
    super.initState();
    getUserInfo();
    pageIndex = widget.pageNumber;
    pageController = PageController(initialPage: widget.pageNumber);
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    // pageController.jumpToPage(pageIndex);
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: buildHomeScreen(),
    );
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      extendBody: true,
      body: PageView(
        children: <Widget>[
          StatisticsScreen(),
          DiaryScreen(),
          CaloriePredictorScreen(),
          ToolsScreen(),
          ProfileScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        animationDuration: Duration(milliseconds: 300),
        height: 58,
        backgroundColor: Colors.transparent,
        color: kNavyBlue,
        buttonBackgroundColor: kNavyBlue,
        animationCurve: Curves.easeInOut,
        onTap: onTap,
        // letIndexChange: (index) => true,
        items: <Widget>[
          SvgPicture.asset("assets/svgs/heartbeat.svg", height: 28, width: 28),
          // Icon(FontAwesomeIcons.heartbeat, color: Colors.white, size: 22),
          SvgPicture.asset("assets/svgs/diary.svg", height: 28, width: 28),
          // Image.asset("assets/images/diary2.png", height: 28, width: 28),
          // Icon(MaterialCommunityIcons.book, color: Colors.white, size: 22),
          SvgPicture.asset("assets/svgs/calories.svg", height: 32, width: 32),
          // Image.asset("assets/images/calories.png", height: 36, width: 36),
          // Icon(FontAwesomeIcons.hamburger, color: Colors.white, size: 22),
          SvgPicture.asset("assets/svgs/tools.svg", height: 28, width: 28),
          // Image.asset("assets/images/tools.png", height: 28, width: 28),
          // Icon(FontAwesomeIcons.tools, color: Colors.white, size: 22),
          SvgPicture.asset("assets/svgs/user.svg", height: 28, width: 28),
          // Icon(FontAwesomeIcons.solidUser, color: Colors.white, size: 22),
        ],
      ),
    );
  }
}

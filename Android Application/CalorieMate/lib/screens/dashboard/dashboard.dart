import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_predictor.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/loading.dart';
import 'package:calorie_mate/screens/dashboard/diary/diary.dart';
import 'package:calorie_mate/screens/dashboard/profile/profile.dart';
import 'package:calorie_mate/screens/dashboard/statistics/statistics.dart';
import 'package:calorie_mate/screens/dashboard/tools/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class DashBoard extends StatefulWidget {
  static final String id = '/DashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController pageController;
  int pageIndex = 0;

  User signInUser = FirebaseAuth.instance.currentUser;

  Future<void> getUserInfo() async {
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
          print("dsdsad" + retGetUserObjFirebase.userID);
          Provider.of<General_Provider>(context, listen: false)
              .set_user(retGetUserObjFirebase);
          try {
            Provider.of<General_Provider>(context, listen: false)
                .set_firebase_user(signInUser);
            print("User Signed In, Proceeding to Dashboard");
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return DashBoard();
            //   },
            // ));
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
    pageController = PageController();
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
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 1),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 0.5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: onTap,
          selectedItemColor: kPrimaryAccentColor,
          unselectedItemColor: Colors.black87,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          elevation: 12,
          selectedIconTheme: IconThemeData(size: 22),
          unselectedIconTheme: IconThemeData(size: 20),
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              label: "Statistics",
              icon: Icon(
                FontAwesomeIcons.heartbeat,
              ),
            ),
            BottomNavigationBarItem(
              label: "Diary",
              icon: Icon(
                MaterialCommunityIcons.book,
              ),
            ),
            BottomNavigationBarItem(
              label: "Calorie Predictor",
              icon: Icon(
                FontAwesomeIcons.hamburger,
              ),
            ),
            BottomNavigationBarItem(
              label: "Tools",
              icon: Icon(
                FontAwesomeIcons.tools,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                FontAwesomeIcons.solidUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

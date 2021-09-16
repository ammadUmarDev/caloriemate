import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_predictor.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/loading.dart';
import 'package:calorie_mate/screens/dashboard/diary/dairy.dart';
import 'package:calorie_mate/screens/dashboard/profile/profile.dart';
import 'package:calorie_mate/screens/dashboard/statistics/statistics.dart';
import 'package:calorie_mate/screens/dashboard/tools/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class DashBoard extends StatefulWidget {
  static final String id = '/DashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
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
        child: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: kPrimaryAccentColor,
          inactiveColor: kPrimaryLightColor.withOpacity(0.4),
          items: [
            BottomNavigationBarItem(
              label: "Statistics",
              icon: Icon(
                FontAwesomeIcons.heartbeat,
                size: kIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: "Diary",
              icon: Icon(
                FontAwesomeIcons.book,
                size: kIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: "Calorie Predictor",
              icon: Icon(
                FontAwesomeIcons.hamburger,
                size: kIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: "Tools",
              icon: Icon(
                FontAwesomeIcons.tools,
                size: kIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                FontAwesomeIcons.solidUser,
                size: kIconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

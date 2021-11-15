import 'package:auto_size_text/auto_size_text.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/profile/faq_page.dart';
import 'package:calorie_mate/screens/dashboard/profile/settings/general_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants.dart';
import '../dashboard.dart';
import 'about_us.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user;
  String description = "Null";
  String userImagePath;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    userImagePath = "assets/icons/user.png";
    user = Provider.of<General_Provider>(context, listen: false).get_user();

    // ignore: missing_return
    Widget showDesciption() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                  child: CircleAvatar(
                    child: SvgPicture.asset("assets/svgs/user.svg", width: 54),
                    // ClipOval(
                    //   child:
                    //   Image.asset(
                    //     userImagePath,
                    //     width: 60,
                    //   ),
                    // ),
                    maxRadius: 42,
                    // backgroundImage: AssetImage(userImagePath),
                    backgroundColor: kYellow,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          H3(textBody: "Name: "),
                          SizedBox(height: 5),
                          BodyText(
                              textBody:
                                  user == null ? "Loading..." : user.fullName),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          H3(textBody: "Email: "),
                          SizedBox(height: 5),
                          SizedBox(
                            width: 180,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: BodyText(
                                textBody:
                                    user == null ? "Loading..." : user.email,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          H3(textBody: "Phone Number: "),
                          SizedBox(height: 5),
                          BodyText(
                              textBody: user.phoneNumber == null
                                  ? "unset"
                                  : user.phoneNumber),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: InkWell(
                    splashColor: Colors.black38,
                    child:
                        SvgPicture.asset("assets/svgs/edit2.svg", height: 24),
                    onTap: () {
                      Navigator.of(context).pushNamed('/EditProfile');
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H3(textBody: "Age"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody: user.age == null
                              ? "unset"
                              : (user.age).toString()),
                      SizedBox(height: 10),
                      H3(textBody: "Current Weight"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody: user.currentWeight == null
                              ? "unset"
                              : (user.currentWeight).toString() + " kg"),
                      SizedBox(height: 10),
                      H3(textBody: "Target Weight"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody: user.targettedWeight == null
                              ? "unset"
                              : (user.targettedWeight).toString() + " kg"),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    H3(textBody: "Gender"),
                    SizedBox(height: 5),
                    BodyText(
                        textBody: user.gender == null ? "unset" : user.gender),
                    SizedBox(height: 10),
                    H3(textBody: "Height"),
                    SizedBox(height: 5),
                    BodyText(
                        textBody: user.heightFt == null
                            ? "unset"
                            : user.heightFt.toString() +
                                "\' " +
                                user.heightIn.toString() +
                                "\""),
                    SizedBox(height: 10),
                    H3(textBody: "Activity Level"),
                    SizedBox(height: 5),
                    BodyText(
                        textBody: user.physicalActivityLevel == null
                            ? "unset"
                            : user.physicalActivityLevel),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget RoundContainerBox(Widget child) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: child,
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarPageName(
          pageName: "My Profile",
          leading: false,
          helpAlertTitle: "Profile Manager Help",
          helpAlertBody:
              "View and edit profile information, read FAQs and learn more about us."),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              children: <Widget>[
                RoundContainerBox(showDesciption()),
                SizedBox(height: 5),
                Divider(),
                RoundContainerBox(ListTile(
                  title: H1(textBody: 'Settings'),
                  subtitle:
                      BodyText(textBody: 'Change account details & logout'),
                  leading:
                      SvgPicture.asset("assets/svgs/settings.svg", width: 40),
                  // Icon(
                  //   FontAwesomeIcons.userCog,
                  //   size: kIconSize,
                  //   color: kCGBlue,
                  // ),
                  trailing: Icon(Icons.chevron_right,
                      color: kCGBlue, size: kIconSize),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => GeneralSettingsScreen())),
                )),
                RoundContainerBox(ListTile(
                  title: H1(textBody: 'FAQ'),
                  subtitle: BodyText(textBody: 'Questions and Answer'),
                  leading: SvgPicture.asset("assets/svgs/faqs.svg", width: 40),
                  // Icon(
                  //   FontAwesomeIcons.solidQuestionCircle,
                  //   size: kIconSize,
                  //   color: kCGBlue,
                  // ),
                  trailing: Icon(Icons.chevron_right,
                      color: kCGBlue, size: kIconSize),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqScreen())),
                )),
                RoundContainerBox(ListTile(
                  title: H1(textBody: 'About Us'),
                  subtitle: BodyText(textBody: 'Get to know TripleA'),
                  leading: SvgPicture.asset("assets/svgs/info.svg", width: 40),
                  // Icon(
                  //   FontAwesomeIcons.building,
                  //   size: kIconSize,
                  //   color: kCGBlue,
                  // ),
                  trailing: Icon(Icons.chevron_right,
                      color: kCGBlue, size: kIconSize),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AboutScreen())),
                )),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

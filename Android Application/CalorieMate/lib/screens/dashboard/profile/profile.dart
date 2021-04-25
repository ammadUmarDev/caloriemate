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

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // user = Provider.of<General_Provider>(context, listen: false).get_user();
    // if (user == null) {
    //   print("user obj is null");
    // }
  }

  @override
  Widget build(BuildContext context) {
    userImagePath = "assets/icons/custIcon.png";
    // user = Provider.of<General_Provider>(context, listen: false).get_user();

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
                  padding: const EdgeInsets.only(right: 20, top: 10,bottom: 10),
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundImage: AssetImage(userImagePath),
                    backgroundColor: kPrimaryAccentColor,
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
                          BodyText(textBody: user == null ? "Loading..." : user.fullName),

                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          H3(textBody: "Email: "),
                          SizedBox(height: 5),
                          BodyText(textBody: user == null ? "Loading..." : user.email),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          H3(textBody: "Phone Number: "),
                          SizedBox(height: 5),
                          BodyText(textBody: user == null ? "Loading..." : user.phoneNumber),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 10),
                      // H3(textBody: "User ID:"),
                      // SizedBox(height: 5),
                      // BodyText(
                      //     textBody: user == null
                      //         ? "Loading..."
                      //         : user.userID.substring(0, 10)),

                      SizedBox(height: 10),
                      H3(textBody: "Age:"),
                      SizedBox(height: 5),
                      BodyText(textBody: user == null ? "Loading..." : user.age),
                      SizedBox(height: 10),
                      H3(textBody: "Current Weight:"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:user == null ? "Loading..." : user.currentWeight),
                      SizedBox(height: 10),
                      H3(textBody: "Targetted Weight:"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:user == null ? "Loading..." : user.targettedWeight),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    H3(textBody: "Gender:"),
                    SizedBox(height: 5),
                    BodyText(textBody: user == null ? "Loading..." : user.gender),
                    SizedBox(height: 10),
                    H3(textBody: "Height:"),
                    SizedBox(height: 5),
                    BodyText(textBody: user == null ? "Loading..." : user.heightFt.toString()+"ft "+user.heightIn.toString()+"in"),
                    SizedBox(height: 10),
                    H3(textBody: "Physical Activity:"),
                    SizedBox(height: 5),
                    BodyText(textBody: user == null ? "Loading..." : user.physicalActivityLevel),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget RoundContainerBox(Widget child){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
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
      appBar: AppBarPageName(pageName: "My Profile",helpAlertTitle: "Profile Manager Help",helpAlertBody: "View and edit profile information, read FAQs and learn more about us."),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                RoundContainerBox(showDesciption()),
                SizedBox(height: 5),
                Divider(),
                RoundContainerBox(ListTile(
                  title: H1(textBody: 'Settings'),
                  subtitle: BodyText(textBody:'Change account details and logout'),
                  leading: Icon(FontAwesomeIcons.userCog, size: kIconSize),
                  trailing:
                  Icon(Icons.chevron_right, color: kPrimaryLightColor, size: kIconSize),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => GeneralSettingsScreen())),
                )),
                RoundContainerBox(ListTile(
                  title: H1(textBody:'FAQ'),
                  subtitle: BodyText(textBody:'Questions and Answer'),
                  leading: Icon(FontAwesomeIcons.solidQuestionCircle, size: kIconSize),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor, size: kIconSize),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqScreen())),
                )),
                RoundContainerBox(ListTile(
                  title: H1(textBody:'About Us'),
                  subtitle: BodyText(textBody:'Get to know TripleA'),
                  leading: Icon(FontAwesomeIcons.building, size: kIconSize),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor, size: kIconSize),
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

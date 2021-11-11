import 'package:calorie_mate/constants.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/screens/authentication/login_signup.dart';
import 'package:calorie_mate/screens/dashboard/profile/components/background_setting.dart';
import 'package:calorie_mate/screens/dashboard/profile/settings/security_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'account_settings_screen.dart';

class GeneralSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBarPageName(pageName: "General Settings"),
      body: BackgroundS(
        child: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: H1(textBody: "Account Settings"),
                              leading: Icon(
                                FontAwesomeIcons.userCog,
                                size: kIconSize,
                                color: kIconColor,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => AccountSettingScreen())),
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            ListTile(
                              title: H1(textBody: 'Security Settings'),
                              leading: Icon(
                                FontAwesomeIcons.userLock,
                                size: kIconSize,
                                color: kIconColor,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => SecuritySettingsState())),
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            ListTile(
                              title: H1(textBody: 'Sign out'),
                              leading: Icon(
                                FontAwesomeIcons.signOutAlt,
                                size: kIconSize,
                                color: kIconColor,
                              ),
                              onTap: () async {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => LoginSignupScreen()));
                              },
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}

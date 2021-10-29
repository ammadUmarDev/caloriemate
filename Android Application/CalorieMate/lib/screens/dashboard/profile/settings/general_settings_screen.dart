import 'package:calorie_mate/constants.dart';
import 'package:calorie_mate/general_components/appbar.dart';
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
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text('Account Settings'),
                              leading: Icon(FontAwesomeIcons.userCog,
                                  size: kIconSize),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => AccountSettingScreen())),
                            ),
                            ListTile(
                              title: Text('Security Settings'),
                              leading: Icon(FontAwesomeIcons.userLock,
                                  size: kIconSize),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => SecuritySettingsState())),
                            ),
                            ListTile(
                                title: Text('Sign out'),
                                leading: Icon(FontAwesomeIcons.signOutAlt,
                                    size: kIconSize),
                                onTap: () async {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => LoginSignupScreen()));
                                }),
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

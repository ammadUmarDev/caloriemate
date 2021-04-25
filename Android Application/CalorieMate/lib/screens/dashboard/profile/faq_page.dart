import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<Panel> panels = [
    Panel(
        'Q: What is CalorieMate all about?',
        "A: CalorieMate is a lifestyle cross-platform app spanning on both food and fitness offering a new way of living a healthy lifestyle. It does so using machine learning/deep learning techniques to predict the daily calorie intake along with the serving size/quantity of fast-food by taking a picture of the meal. The application further maintains a diary, provides meal and training trackers and recommends calorie intake to reach a weight goal relative to each user's profile.",
        false),
    Panel(
        'Q: How many accounts can I own?',
        'A: Corresponding to one email, you can create only one account.',
        false),
    Panel(
        'Q: Can I edit my profile?',
        'A: Yes, you can edit your profile by going to Profile. Edit icon in the top right corner',
        false),
    Panel(
        'Q: Can I change my password?',
        'A: Yes, you can do this by going into Profile -> Security Settings.',
        false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBarPageName(
        pageName: "FAQs",
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView(
            children: <Widget>[
              ...panels
                  .map((panel) => ExpansionTile(
                          title: H3(textBody: panel.title),
                          children: [
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: kTextLightColor.withOpacity(0.3),
                                child: BodyText(textBody: panel.content))
                          ]))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}

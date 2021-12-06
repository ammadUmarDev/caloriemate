import 'package:calorie_mate/constants.dart';
import 'package:calorie_mate/general_components/card.dart';
import 'package:calorie_mate/general_components/genderRadio.dart';
import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/general_components/text_field_container.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';

enum Gender { Male, Female }
enum PhysicalActivityLevel { Sedentary, Light, Moderate, Vigorous }

extension ParseToString on Gender {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

extension ParseToString2 on PhysicalActivityLevel {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  String age;
  Gender _gender;
  String currentWeight;
  String targettedWeight;
  String heightFt;
  String heightIn;
  PhysicalActivityLevel _physicalActivityLevel;

  bool showNext = true;
  bool showDone = false;

  UserModel userObj;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    changeAge(userObj, int.parse(age));
    changeGender(userObj, _gender.toShortString());
    changeHeight(userObj, int.parse(heightFt), int.parse(heightIn));

    changeCurrentWeight(userObj, double.parse(currentWeight));
    changeTargettedWeight(userObj, double.parse(targettedWeight));
    changePhysicalActivityLevel(
        userObj, _physicalActivityLevel.toShortString());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DashBoard(pageNumber: 2),
      ),
    );
  }

  ScrollPhysics scrollPhysics() {
    if (showNext == true) {
      return BouncingScrollPhysics();
    } else
      return LeftBlockedScrollPhysics();
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    userObj = Provider.of<General_Provider>(context, listen: false).get_user();

    const bodyStyle = TextStyle(fontSize: 20.0, color: Colors.white);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 36.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
      pageColor: kNavyBlue,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: IntroductionScreen(
        scrollPhysics: scrollPhysics(),
        key: introKey,
        globalBackgroundColor: kNavyBlue,
        globalHeader: Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              // child: _buildImage('CMLogo.png', 72),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          introKey.currentState.previous();
                        });
                      }),
                ),
              ),
            ),
          ),
        ),
        pages: [
          PageViewModel(
            title: "We need some information from you before we can proceed",
            body: "",
            image: _buildImage('CMLogo.png', 240),
            decoration: pageDecoration.copyWith(
              titleTextStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          PageViewModel(
            title: "How old are you?",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  child: TextField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hintText: "0-99",
                      counterText: "",
                      hintStyle: TextStyle(color: Colors.white54),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        age = value.toString();
                        showNext = true;
                        if (value.isEmpty) {
                          showNext = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 1,
              bodyAlignment: Alignment.center,
              // fullScreen: true,
            ),
          ),
          PageViewModel(
            title: "What's your gender?",
            bodyWidget: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GenderRadio(
                      onPress: () {
                        setState(() {
                          _gender = Gender.Male;
                          showNext = true;
                        });
                      },
                      color:
                          _gender == Gender.Male ? Colors.black38 : kNavyBlue,
                      icon: SvgPicture.asset("assets/svgs/male.svg", width: 95),
                      text: 'MALE',
                      textColor: Colors.white,
                    ),
                    Spacer(),
                    GenderRadio(
                      onPress: () {
                        setState(() {
                          _gender = Gender.Female;
                          showNext = true;
                        });
                      },
                      color:
                          _gender == Gender.Female ? Colors.black38 : kNavyBlue,
                      icon:
                          SvgPicture.asset("assets/svgs/female.svg", width: 95),
                      text: 'FEMALE',
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 1,
              bodyAlignment: Alignment.center,
              // fullScreen: true,
            ),
          ),
          PageViewModel(
            title: "Specify your height",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 90,
                  child: TextField(
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hintText: "Ft",
                      counterText: "",
                      hintStyle: TextStyle(color: Colors.white54),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        heightFt = value.toString();
                        if (heightIn != null) {
                          showNext = true;
                        }
                        if (value.isEmpty) {
                          showNext = false;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: TextField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hintText: "In",
                      hintStyle: TextStyle(color: Colors.white54),
                      counterText: "",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        heightIn = value.toString();
                        if (heightFt != null) {
                          showNext = true;
                        }
                        if (value.isEmpty) {
                          showNext = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 1,
              bodyAlignment: Alignment.center,
              // fullScreen: true,
            ),
          ),
          PageViewModel(
            title: "How much do you weigh right now?",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  child: TextField(
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hintText: "kg",
                      counterText: "",
                      hintStyle: TextStyle(color: Colors.white54),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        currentWeight = value.toString();
                        showNext = true;

                        if (value.isEmpty) {
                          showNext = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 1,
              bodyAlignment: Alignment.center,
              // fullScreen: true,
            ),
          ),
          PageViewModel(
            title: "What is your targetted weight?",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  child: TextField(
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hintText: "kg",
                      counterText: "",
                      hintStyle: TextStyle(color: Colors.white54),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        targettedWeight = value.toString();
                        showNext = true;

                        if (value.isEmpty) {
                          showNext = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 1,
              bodyAlignment: Alignment.center,
              // fullScreen: true,
            ),
          ),
          PageViewModel(
            title: "How would you describe your physical activity level?",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Radio<PhysicalActivityLevel>(
                      value: PhysicalActivityLevel.Sedentary,
                      fillColor:
                          MaterialStateColor.resolveWith((states) => kCGBlue),
                      groupValue: _physicalActivityLevel,
                      onChanged: (PhysicalActivityLevel value) {
                        setState(() {
                          _physicalActivityLevel = value;
                          showDone = true;
                          print(_physicalActivityLevel.toShortString());
                        });
                      },
                    ),
                    Text(
                      "Sedentary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Radio<PhysicalActivityLevel>(
                      value: PhysicalActivityLevel.Light,
                      fillColor:
                          MaterialStateColor.resolveWith((states) => kCGBlue),
                      groupValue: _physicalActivityLevel,
                      onChanged: (PhysicalActivityLevel value) {
                        setState(() {
                          _physicalActivityLevel = value;
                          showDone = true;

                          print(_physicalActivityLevel.toShortString());
                        });
                      },
                    ),
                    Text(
                      "Light",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Radio<PhysicalActivityLevel>(
                      value: PhysicalActivityLevel.Moderate,
                      groupValue: _physicalActivityLevel,
                      fillColor:
                          MaterialStateColor.resolveWith((states) => kCGBlue),
                      onChanged: (PhysicalActivityLevel value) {
                        setState(() {
                          _physicalActivityLevel = value;
                          showDone = true;

                          print(_physicalActivityLevel.toShortString());
                        });
                      },
                    ),
                    Text(
                      "Moderate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Radio<PhysicalActivityLevel>(
                      value: PhysicalActivityLevel.Vigorous,
                      fillColor:
                          MaterialStateColor.resolveWith((states) => kCGBlue),
                      groupValue: _physicalActivityLevel,
                      onChanged: (PhysicalActivityLevel value) {
                        setState(() {
                          _physicalActivityLevel = value;
                          showDone = true;
                          print(_physicalActivityLevel.toShortString());
                        });
                      },
                    ),
                    Text(
                      "Vigorous",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 1,
              bodyAlignment: Alignment.center,
              // fullScreen: true,
            ),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        skipFlex: 0,
        nextFlex: 0,
        //rtl: true, // Display as right-to-left
        skip: const Text('Skip'),
        onChange: (value) {
          if (value == 0) {
            setState(() {
              showNext = true;
            });
          } else {
            setState(() {
              showNext = false;
            });
          }
        },
        showNextButton: showNext,
        showDoneButton: showDone,
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}

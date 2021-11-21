import 'dart:io';

import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h1.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants.dart';

class CaloriePredictorScreen extends StatefulWidget {
  static final String id = '/CaloriePredictor';
  @override
  _CaloriePredictorScreenState createState() => _CaloriePredictorScreenState();
}

class _CaloriePredictorScreenState extends State<CaloriePredictorScreen> {
  // FoodImage foodImages;

  File topView;
  File sideView;

  final imagePicker = ImagePicker();

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future getTopImageFromCamera() async {
    final topImage = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      topView = File(topImage.path);
      //upload image to storage in firebase
      Reference reference = _storage.ref().child("images/topView.jpg");
      UploadTask uploadTask = reference.putFile(topView);
    });
    Alert(
      context: context,
      title: "Side View",
      closeIcon: Icon(
        FontAwesomeIcons.timesCircle,
        color: kPrimaryLightColor,
      ),
      style: AlertStyle(
        overlayColor: Colors.black45,
        titleStyle: H1TextStyle(color: kCGBlue),
      ),
      content: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          H2(textBody: "Capture the side view of the food"),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: kCGBlue,
          width: 100,
          radius: BorderRadius.circular(10),
          child: Text(
            'GO',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: kH1Size),
          ),
          onPressed: () {
            getSideImageFromCamera();
            Navigator.pop(context);
          },
        ),
      ],
    ).show();
  }

  Future getSideImageFromCamera() async {
    final sideImage = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      sideView = File(sideImage.path);
      Reference reference = _storage.ref().child("images/sideView.jpg");
      UploadTask uploadTask = reference.putFile(sideView);
    });
    Navigator.of(context).pushNamed('/LoadingScreen');
  }

  //

  Future getTopImageFromGallery() async {
    final topImage = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      topView = File(topImage.path);
      Reference reference = _storage.ref().child("images/topView.jpg");
      UploadTask uploadTask = reference.putFile(topView);
    });
    Alert(
      context: context,
      title: "Side View",
      closeIcon: Icon(
        FontAwesomeIcons.timesCircle,
        color: kPrimaryLightColor,
      ),
      style: AlertStyle(
        overlayColor: Colors.black45,
        titleStyle: H1TextStyle(color: kCGBlue),
      ),
      content: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          H2(textBody: "Upload the side view of the food"),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: kCGBlue,
          width: 100,
          radius: BorderRadius.circular(10),
          child: Text(
            'GO',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: kH1Size),
          ),
          onPressed: () {
            getSideImageFromGallery();
            Navigator.pop(context);
          },
        ),
      ],
    ).show();
  }

  Future getSideImageFromGallery() async {
    final sideImage = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      sideView = File(sideImage.path);
      Reference reference = _storage.ref().child("images/sideView.jpg");
      UploadTask uploadTask = reference.putFile(sideView);
    });
    Navigator.of(context).pushNamed('/LoadingScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarPageName(
            pageName: "Calorie Predictor",
            leading: false,
            helpAlertTitle: "Calorie Predictor Help",
            helpAlertBody:
                "Take top view and side view image of your meal using our camera. For accurate results take the picture approximately two feet away from your meal."),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(1000),
                      color: kPrussianBlue,
                    ),
                    child: ClipOval(
                      child: Image.asset("assets/images/cals_woman.jpg"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    child: InkWell(
                      // splashColor: kYellow.withAlpha(50),
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Alert(
                          context: context,
                          title: "Top View",
                          closeIcon: Icon(
                            FontAwesomeIcons.timesCircle,
                            color: kPrimaryLightColor,
                          ),
                          style: AlertStyle(
                            overlayColor: Colors.black45,
                            titleStyle: H1TextStyle(color: kCGBlue),
                          ),
                          content: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              H2(textBody: "Capture the top view of the food"),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              color: kCGBlue,
                              width: 100,
                              radius: BorderRadius.circular(10),
                              child: Text(
                                'GO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: kH1Size),
                              ),
                              onPressed: () {
                                getTopImageFromCamera();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ).show();
                      },
                      child: Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(14),
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 0.0), //(x,y)
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  color: kYellow,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: SvgPicture.asset(
                                    "assets/svgs/camera.svg",
                                    width: 100),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      H1(
                                        textBody: "Capture Image",
                                        color: Colors.black87,
                                      ),
                                      SizedBox(height: 5),
                                      H3(
                                        textBody:
                                            "Use camera to capture\nimage and detect\ncalories",
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      // splashColor: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Alert(
                          context: context,
                          title: "Top View",
                          closeIcon: Icon(
                            FontAwesomeIcons.timesCircle,
                            color: kPrimaryLightColor,
                          ),
                          style: AlertStyle(
                            overlayColor: Colors.black45,
                            titleStyle: H1TextStyle(color: kCGBlue),
                          ),
                          content: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              H2(
                                textBody: "Upload the top view of the food",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              color: kCGBlue,
                              width: 100,
                              radius: BorderRadius.circular(10),
                              child: Text(
                                'GO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: kH1Size),
                              ),
                              onPressed: () {
                                getTopImageFromGallery();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ).show();
                      },
                      child: Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(14),
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 0.0), //(x,y)
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  color: kYellow,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: SvgPicture.asset(
                                    "assets/svgs/upload.svg",
                                    width: 100),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      H1(
                                        textBody: "Upload Image",
                                        color: Colors.black87,
                                      ),
                                      SizedBox(height: 5),
                                      H3(
                                        textBody:
                                            "Upload an image from\ngallery and detect\ncalories",
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

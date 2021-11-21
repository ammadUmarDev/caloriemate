import 'package:calorie_mate/general_components/h1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../constants.dart';
import '../../general_components/buttonErims.dart';
import '../../general_components/h2.dart';
import '../../general_components/h3.dart';
import '../../general_components/text_Field_outlined.dart';
import '../../models/user.dart';
import '../../providers/firebase_functions.dart';
import '../../providers/general_provider.dart';
import '../dashboard/dashboard.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';

import '../../general_components/or_divider.dart';
import '../dashboard/components/main_background.dart';

class LoginSignupScreen extends StatefulWidget {
  static String id = '/LoginSignup';
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;

  String name;
  String email;
  String password;
  bool authCheckFields = false;
  bool _showSpinner = false;

  // @override
  // Future<void> initState() async {
  //   // TODO: implement initState
  //   super.initState();
  //   if (await FirebaseAuth.instance.currentUser != null) {
  //     Navigator.pushNamed(context, DashBoard.id);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    Widget signupButton = ButtonErims(
      color: kYellow,
      textColor: Colors.black87,
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          print('User Signing Up:');
          print(fullNameTextField.getReturnValue());
          print(emailTextFieldSignup.getReturnValue());
          print(passwordTextFieldSignup.getReturnValue());
          String fullNameRetValue =
              fullNameTextField.getReturnValue().toString();
          String emailRetValue =
              emailTextFieldSignup.getReturnValue().toString().trim();
          String passRetValue =
              passwordTextFieldSignup.getReturnValue().toString().trim();
          try {
            if (fullNameRetValue.toString().isEmpty &&
                fullNameRetValue.toString().startsWith(' ') &&
                fullNameRetValue.toString().endsWith(' ') &&
                fullNameRetValue.toString().contains(' ') == false &&
                emailRetValue.toString().contains('@') != false &&
                emailRetValue.toString().endsWith('.com') != false &&
                passRetValue.toString().length <= 6) {
              setState(() {
                //cannot allow signup
                authCheckFields = false;
              });
            } else {
              setState(() {
                //allow signup
                authCheckFields = true;
              });
            }
            if (authCheckFields == true) {
              final createUser = (await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailTextFieldSignup.getReturnValue().trim(),
                          password:
                              passwordTextFieldSignup.getReturnValue().trim()))
                  .user;
              if (createUser != null) {
                final currentUserId = createUser.uid;
                final createdUserModelObj = UserModel(
                  userID: currentUserId,
                  fullName: fullNameTextField.getReturnValue(),
                  email: emailTextFieldSignup.getReturnValue().trim(),
                  createdDate: DateFormat("dd/MM/yyyy")
                      .format(DateTime.now())
                      .toString(),
                  lastPassChangeDate: DateFormat("dd/MM/yyyy")
                      .format(DateTime.now())
                      .toString(),
                );
                signupFirebaseDb(createdUserModelObj).then((retUser) async {
                  try {
                    Provider.of<General_Provider>(context, listen: false)
                        .set_user(createdUserModelObj);
                    try {
                      Provider.of<General_Provider>(context, listen: false)
                          .set_firebase_user(createUser);
                      print("User Created, Proceeding to Dashboard");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DashBoard();
                        },
                      ));
                      stopLoading();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }

                    print('set_firebase_user');
                  } catch (e) {
                    print(e);
                  }
                });
              }
            }
          } catch (e) {
            print(e);
          }
        } else {
          stopLoading();
        }
      },
      labelText: "SIGN UP",
    );

    Widget loginButton = ButtonErims(
      color: kYellow,
      textColor: Colors.black87,
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          print('Attempting signing  in:');
          print(emailTextFieldLogin.getReturnValue());
          print(passwordTextFieldLogin.getReturnValue());
          String emailRetValue =
              emailTextFieldLogin.getReturnValue().toString().trim();
          String passRetValue =
              passwordTextFieldLogin.getReturnValue().toString().trim();
          try {
            if (emailRetValue.toString().contains('@') != false &&
                emailRetValue.toString().endsWith('.com') != false &&
                passRetValue.toString().length <= 6) {
              setState(() {
                //cannot allow signup
                authCheckFields = false;
              });
            } else {
              setState(() {
                //allow signup
                authCheckFields = true;
              });
            }
            if (authCheckFields == true) {
              final signInUser = (await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailTextFieldLogin.getReturnValue().trim(),
                          password:
                              passwordTextFieldLogin.getReturnValue().trim()))
                  .user;
              print("we here ");
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
                      phoneNumber:
                          documentSnapshot.data()["Phone_Number"].toString(),
                      age: documentSnapshot.data()["Age"],
                      gender: documentSnapshot.data()["Gender"].toString(),
                      currentWeight: documentSnapshot.data()["Current_Weight"],
                      targettedWeight:
                          documentSnapshot.data()["Targetted_Weight"],
                      heightFt: documentSnapshot.data()["Height_Ft"],
                      heightIn: documentSnapshot.data()["Height_In"],
                      physicalActivityLevel: documentSnapshot
                          .data()["Physical_Activity_Level"]
                          .toString(),
                      createdDate:
                          documentSnapshot.data()["Created_Date"].toString(),
                      lastPassChangeDate: documentSnapshot
                          .data()["Last_Pass_Change_Date"]
                          .toString(),
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
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DashBoard();
                        },
                      ));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                    stopLoading();
                  } catch (e) {
                    print(e);
                  }
                } else {
                  print("retGetUserDocFirebase is null");
                }
              }
            }
          } catch (e) {
            print(e);
          }
        } else {
          stopLoading();
        }
      },
      labelText: "LOG IN",
    );

    Widget buildSignup() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Form(
          child: Column(
            children: [
              fullNameTextField,
              SizedBox(
                height: 20,
              ),
              emailTextFieldSignup,
              SizedBox(
                height: 20,
              ),
              passwordTextFieldSignup,
              SizedBox(
                height: 40,
              ),
              signupButton,
            ],
          ),
        ),
      );
    }

    Widget buildLogin() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Form(
          child: Column(
            children: [
              emailTextFieldLogin,
              SizedBox(
                height: 20,
              ),
              passwordTextFieldLogin,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 13,
                        color: kTextDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
              loginButton,
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xFFE9EEF5),
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 290,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kNavyBlue,
                    kNavyBlue,
                    kNavyBlue,
                    kNavyBlue,
                    kNavyBlue,
                  ],
                  stops: [
                    0.1,
                    0.3,
                    0.5,
                    0.7,
                    0.9,
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/CMLogoDark.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 25),
                      child: RichText(
                        text: TextSpan(
                          text: isSignupScreen
                              ? "Welcome to CalorieMate"
                              : "Welcome Back",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        isSignupScreen
                            ? "Sign Up to Continue"
                            : "Log In to Continue",
                        style: TextStyle(
                          fontSize: 15,
                          // letterSpacing: 0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            top: isSignupScreen ? 220 : 240,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              height: isSignupScreen ? 400 : 330,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10),
                ],
              ),
              child: SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "LOG IN",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen
                                          ? kDarkAccentColor
                                          : kTextDarkColor),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 60,
                                    color: kYellowDark,
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? kDarkAccentColor
                                          : kTextDarkColor),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 75,
                                    color: kYellowDark,
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                      if (isSignupScreen) buildSignup(),
                      if (!isSignupScreen) buildLogin()
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom buttons
          Positioned(
            top: MediaQuery.of(context).size.height - 130,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 1.5,
                      color: Colors.black26,
                    ),
                    H2(textBody: "  OR  "),
                    Container(
                      width: 50,
                      height: 1.5,
                      color: Colors.black26,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // buildTextButton(MaterialCommunityIcons.facebook, "Facebook",
                      //     facebookColor),
                      buildBottomButton(
                          MaterialCommunityIcons.google, "Google", Colors.white)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFieldOutlined fullNameTextField = TextFieldOutlined(
    textFieldText: 'Name',
    textFieldIcon: Icon(
      FontAwesomeIcons.solidUser,
      size: 20,
      color: kIconColor,
    ),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().isEmpty &&
          entry.toString().startsWith(' ') &&
          entry.toString().endsWith(' ') &&
          entry.toString().contains(' ') == false) {
        return 'Invalid Full Name';
      }
      return '';
    },
  );

  TextFieldOutlined emailTextFieldLogin = TextFieldOutlined(
    textFieldText: 'Email (example@gmail.com)',
    textFieldIcon: Icon(
      FontAwesomeIcons.solidEnvelopeOpen,
      size: 20,
      color: kIconColor,
    ),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().contains('@') && entry.toString().endsWith('.com'))
        return '';
      return 'Invalid Email';
    },
    onChanged: () {},
  );

  TextFieldOutlined passwordTextFieldLogin = TextFieldOutlined(
    textFieldText: 'Password',
    textFieldIcon: Icon(
      FontAwesomeIcons.lock,
      size: kIconSize,
      color: kIconColor,
    ),
    obscure: true,
    keyboardType: TextInputType.visiblePassword,
    isValidEntry: (entry) {
      if (entry.toString().length <= 6)
        return 'Minimum Password Length: 6 characters';
      return '';
    },
  );

  TextFieldOutlined emailTextFieldSignup = TextFieldOutlined(
    textFieldText: 'Email (example@gmail.com)',
    textFieldIcon: Icon(
      FontAwesomeIcons.solidEnvelopeOpen,
      size: kIconSize,
      color: kIconColor,
    ),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().contains('@') && entry.toString().endsWith('.com'))
        return '';
      return 'Invalid Email';
    },
    onChanged: () {},
  );

  TextFieldOutlined passwordTextFieldSignup = TextFieldOutlined(
    textFieldText: 'Password',
    textFieldIcon: Icon(
      FontAwesomeIcons.lock,
      size: kIconSize,
      color: kIconColor,
    ),
    obscure: true,
    keyboardType: TextInputType.visiblePassword,
    isValidEntry: (entry) {
      if (entry.toString().length <= 6)
        return 'Minimum Password Length: 6 characters';
      return '';
    },
  );

  TextButton buildBottomButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {
        if (title == "Google") {
          print("Google button pressed");
        }
        Alert(
          context: context,
          title: "Coming Soon",
          closeIcon: Icon(
            FontAwesomeIcons.timesCircle,
            color: kPrimaryLightColor,
          ),
          style: AlertStyle(
            overlayColor: Colors.black45,
            titleStyle: H2TextStyle(color: kNavyBlue),
          ),
          content: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              H3(textBody: "Stay tuned for the next update :)"),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          buttons: [
            DialogButton(
              color: Colors.white,
              height: 0,
              child: SizedBox(height: 0),
              onPressed: () {},
            ),
          ],
        ).show();
      },
      style: TextButton.styleFrom(
        elevation: 5.0,
        // side: BorderSide(width: 1, color: Colors.grey),
        minimumSize: Size(50, 50),
        shape: CircleBorder(),
        primary: Colors.white,
        onSurface: Colors.green,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(0.0),
      ),
      child: Image(
        image: AssetImage("assets/images/google.png"),
        width: 24,
        height: 24,
      ),
    );
  }
}

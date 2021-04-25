import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class LoginSignupScreen extends StatefulWidget {
  static String id = '/LoginSignup';
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;

  bool _togglePassword;

  @override
  void initState() {
    _togglePassword = false;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xFFE9EEF5),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(30, 80, 145, 0.5),
                    Color.fromRGBO(30, 80, 145, 0.6),
                    Color.fromRGBO(30, 80, 145, 0.7),
                    Color.fromRGBO(30, 80, 145, 0.8),
                    Color.fromRGBO(30, 80, 145, 0.9),
                    Color.fromRGBO(30, 80, 145, 1.0)
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/CMLogoDark.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 15),
                      child: RichText(
                        text: TextSpan(
                          text: isSignupScreen
                              ? "Welcome to CalorieMate"
                              : "Welcome Back",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Montserrat",
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

          // Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            top: isSignupScreen ? 310 : 340,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              height: isSignupScreen ? 340 : 290,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5),
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
                                  "LOGIN",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen
                                          ? Color(0xFF09126C)
                                          : Color(0XFFA7BCC7)),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.lightBlue,
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
                                  "SIGNUP",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Color(0xFF09126C)
                                          : Color(0XFFA7BCC7)),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.lightBlue,
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                      if (isSignupScreen) buildSignupSection(),
                      if (!isSignupScreen) buildLoginSection()
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons
          Positioned(
            top: MediaQuery.of(context).size.height - 130,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignupScreen ? "Or Sign Up With" : "Or Log In With"),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // buildTextButton(MaterialCommunityIcons.facebook, "Facebook",
                      //     facebookColor),
                      buildTextButton(
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

  Container buildLoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Form(
        child: Column(
          children: [
            buildTextField(Icons.mail_outline, "Email", false, true),
            SizedBox(
              height: 20,
            ),
            buildTextField(
                MaterialCommunityIcons.lock_outline, "Password", true, false),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Color(0XFFA7BCC7)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Form(
        child: Column(
          children: [
            buildTextField(
                MaterialCommunityIcons.account_outline, "Name", false, false),
            SizedBox(
              height: 20,
            ),
            buildTextField(
                MaterialCommunityIcons.email_outline, "Email", false, true),
            SizedBox(
              height: 20,
            ),
            buildTextField(
                MaterialCommunityIcons.lock_outline, "Password", true, false),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {
        if (title == "Google") {
          print("Google button pressed");
        }
      },
      style: TextButton.styleFrom(
        elevation: 5.0,
        // side: BorderSide(width: 1, color: Colors.grey),
        minimumSize: Size(60, 60),
        shape: CircleBorder(),
        primary: Colors.white,
        onSurface: Colors.green,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(0.0),
      ),

      child: Image(
        image: AssetImage("assets/images/google.png"),
        width: 40,
        height: 40,
      ),
      // child: Row(
      //   children: [
      //     ImageIcon(
      //       AssetImage('assets/images/google.png'),
      //       color: Colors.black,
      //       // size: 40,
      //     ),
      //     SizedBox(
      //       width: 5,
      //     ),
      //   ],
      // ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutBack,
      top: isSignupScreen ? 600 : 580,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[300], Colors.blue[900]],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    var none;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        obscureText: isPassword ? !_togglePassword : false,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Color(0xFFB6C7D1),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _togglePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    setState(() {
                      _togglePassword = !_togglePassword;
                    });
                  },
                )
              : none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFA7BCC7)),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFA7BCC7)),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Color(0XFFA7BCC7)),
        ),
      ),
    );
  }
}

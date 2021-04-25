//Password Change
import 'dart:io';

import 'package:calorie_mate/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Check Internet Availability
Future<bool> internetCheck() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet connected');
    }
  } on SocketException catch (_) {
    print('No internet connection');
    return false;
  }
  return true;
}

//User SignUp
Future<bool> signupFirebaseDb(UserModel user) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  bool internetCheckVar = await internetCheck();
  if (internetCheckVar == false)
    return false;
  else {
    await users.doc(user.userID).set({
      'User_Id': user.userID.toString(),
      'Full_Name': user.fullName.toString(),
      'Email': user.email.toString(),
      'Created_Date': user.createdDate.toString(),
      'Last_Pass_Change_Date': user.lastPassChangeDate.toString(),
      'Phone_Number' : user.phoneNumber,
      'Age' : user.age,
      'Gender' : user.gender,
      'Height_Ft' : user.heightFt,
      'Height_In' : user.heightIn,
      'Current_Weight' : user.currentWeight,
      'Targetted_Weight' : user.targettedWeight,
      'Body_Goal' : user.bodyGoal,
      'Physical_Activity_Level' : user.physicalActivityLevel,
      'Latest_BMI' : user.latestBMIScore,
      'Weight_History' : user.weightHistory,
      'BMI_History' : user.BMIHistory
      //    new DateFormat("dd/MM/yyyy").parse("11/11/2011");
    });
  }
  return true;
}

//User Password Change
Future<bool> changePassword(UserModel u, String enteredPass) async {
  User user = FirebaseAuth.instance.currentUser;
  await user.updatePassword(enteredPass).then((_) async {
    print("Succesfully changed auth password");
    return true;
  }).catchError((error) {
    print("Password can't be changed" + error.toString());
    return false;
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
}

//User Name Change
Future<bool> changeFullName(UserModel u, String newName) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Full_Name': newName})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}


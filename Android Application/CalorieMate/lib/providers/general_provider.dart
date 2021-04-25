import 'package:calorie_mate/models/user.dart';
import 'package:flutter/cupertino.dart';

class General_Provider extends ChangeNotifier {

  UserModel user;
  UserModel get_user() {
    if (user == null) {
      print("User has not been set yet");
    }
    return user;
  }

  void set_user(UserModel u) {
    this.user = u;
  }


// FirebaseUser get_firebase_user() {
//   if (firebaseUser == null) {
//     print("Firebase user has not been set yet");
//   }
//   return firebaseUser;
// }
//
//
// void set_firebase_user(User u) {
//   this.firebaseUser = u;
// }
}

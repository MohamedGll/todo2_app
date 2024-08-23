import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo2_app/firebase_functions.dart';
import 'package:todo2_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  AuthProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseFunctions.getUserData();
    notifyListeners();
  }
}

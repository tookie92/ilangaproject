import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class DbFire {
  //final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic errorMessage = '';
  dynamic errorCode = '';
  //String get getErrorMessage => error;

  Future<void> signin(String emailController, String passwordController,
      BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.trim(), password: passwordController.trim());
      User user = userCredential.user;

      if (user != null) {
        print('geschaft');
      } else {
        throw PlatformException(
            code: errorCode, message: errorMessage as String);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Toast.show(e.code, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  Future<void> signup(String emailController, String passwordController,
      String nameController, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.trim(),
              password: passwordController.trim());
      User user = userCredential.user;
      final currentUser = _auth.currentUser;

      if (user != null) {
        currentUser.updateProfile(displayName: nameController);
        print('geschaft');
      } else {
        throw PlatformException(
            code: errorCode, message: errorMessage as String);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Toast.show(e.code, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}

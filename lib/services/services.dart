import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilanga/blocs/bloc_router.dart';
import 'package:toast/toast.dart';

class DbFire {
  //final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  dynamic errorMessage = '';
  dynamic errorCode = '';
  //String get getErrorMessage => error;

//Sign in
  Future<void> signin(String emailController, String passwordController,
      BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.trim(), password: passwordController.trim());
      User user = userCredential.user;
      User currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        Navigator.pushReplacement(context, BlocRouter().welcomePage(user));
        print('geschaft');
      } else {
        throw PlatformException(
            code: errorCode, message: errorMessage as String);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Toast.show(e.code, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

//Future Sign uo
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
        //add in Database
        DatabaseReference newUserRef =
            FirebaseDatabase.instance.reference().child('users/${user.uid}');

        //Prepared data to be saved
        Map userMap = {
          'name': nameController,
          'email': emailController,
        };

        newUserRef.set(userMap);

        //add name
        currentUser.updateProfile(displayName: nameController);

        //Navigation
        Navigator.of(context).pushReplacement(BlocRouter().welcomePage(user));
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

  //signout
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

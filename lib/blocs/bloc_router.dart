import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_register.dart';
import 'package:ilanga/blocs/bloc_welcome.dart';
import 'package:ilanga/ui/screens/sign_in.dart';
import 'package:ilanga/ui/screens/sign_up.dart';
import 'package:ilanga/ui/screens/welcome.dart';

class BlocRouter {
  MaterialPageRoute signUp() => MaterialPageRoute(builder: (ctx) => signup());
  MaterialPageRoute welcomePage(User user) =>
      MaterialPageRoute(builder: (ctx) => welcome(user));

  //homePage
  BlocProvider signin() =>
      BlocProvider<BlocRegister>(bloc: BlocRegister(), child: SigninPage());

  BlocProvider signup() =>
      BlocProvider<BlocRegister>(bloc: BlocRegister(), child: SignUpPage());
  BlocProvider welcome(User u) =>
      BlocProvider<BlocWelcome>(bloc: BlocWelcome(), child: WelcomePage(u));
}

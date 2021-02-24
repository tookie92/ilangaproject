import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'bloc.dart';

class BlocWelcome extends Bloc {
  final _streamController = StreamController<WelcomeState>();

  Stream<WelcomeState> get stream => _streamController.stream;

  Sink<WelcomeState> get sink => _streamController.sink;

  void init() {
    final resultat =
        WelcomeState(currentUser: FirebaseAuth.instance.currentUser);
    sink.add(resultat);
  }

  BlocWelcome() {
    if (FirebaseAuth.instance.currentUser != null) {
      init();
    }
  }

  @override
  dispose() {
    _streamController.close();
    //throw UnimplementedError();
  }
}

class WelcomeState {
  final User currentUser;

  WelcomeState({this.currentUser});
}

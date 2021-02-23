import 'dart:async';

import 'package:ilanga/blocs/bloc.dart';

class BlocRegister extends Bloc {
  final _streamController = StreamController<RegisterState>();

  Stream<RegisterState> get stream => _streamController.stream;

  Sink<RegisterState> get sink => _streamController.sink;

  void init() {
    final resultat = RegisterState(isActive: true);
    sink.add(resultat);
  }

  BlocRegister() {
    init();
  }

  @override
  dispose() => _streamController.close();
}

class RegisterState {
  final bool isActive;

  RegisterState({this.isActive = false});
}

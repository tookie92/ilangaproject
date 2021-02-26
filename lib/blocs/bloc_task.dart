import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ilanga/blocs/bloc.dart';
import 'package:ilanga/models/tasks.dart';

class BlocTask extends Bloc {
  final db = FirebaseDatabase.instance;
  User user = FirebaseAuth.instance.currentUser;
  final _streamController = StreamController<TaskState>();

  Stream<TaskState> get stream => _streamController.stream;
  Sink<TaskState> get sink => _streamController.sink;

  void init() {
    final resultat = TaskState(
        tasklist: [],
        task: Task('', ''),
        currentUser: FirebaseAuth.instance.currentUser,
        databaseReference: db.reference().child('users/${user.uid}/tasks'));
    sink.add(resultat);
  }

  void create() {
    final resultat = TaskState().createData();
    sink.add(resultat);
  }

  BlocTask() {
    if (Task != null) {
      init();
    }
  }

  @override
  dispose() => _streamController.close();
}

class TaskState {
  List<Task> tasklist;
  DatabaseReference databaseReference;
  final db = FirebaseDatabase.instance;
  final User currentUser;
  Task task;

  TaskState(
      {this.databaseReference, this.task, this.tasklist, this.currentUser});

  createData() {
    databaseReference.push().set(task.toJson()).then((_) => print('geschaft'));
  }

  deleteData() {
    databaseReference.child(task.key).remove();
  }
}

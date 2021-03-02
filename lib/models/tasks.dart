import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Task {
  String key;
  String title;
  String user;

  Task(this.title, this.user);

  Task.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        user = snapshot.value['user'];

  toJson() {
    final String entry = FirebaseAuth.instance.currentUser.displayName;
    return {'title': title, 'user': entry};
  }
}

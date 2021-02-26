import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_router.dart';
import 'package:ilanga/blocs/bloc_welcome.dart';
import 'package:ilanga/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  final User user;

  WelcomePage(this.user);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocWelcome>(context);
    return Scaffold(
      body: StreamBuilder<WelcomeState>(
          stream: bloc.stream,
          builder: (ctx, s) {
            if (s == null && s.data == null) {
              return Center(
                child: Text('nothing'),
              );
            } else if (!s.hasData) {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text('Du bist nicht verbunden'),
                    ),
                    TextButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('email');
                          await DbFire().signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocRouter().signin()));
                        },
                        child: Text('Logout'))
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Bienvenue'),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('email');
                          await DbFire().signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocRouter().signin()));
                        })
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Bienvenue \n${s.data.currentUser.displayName}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(BlocRouter().crudityPage());
                          },
                          child: Text('tasks')),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

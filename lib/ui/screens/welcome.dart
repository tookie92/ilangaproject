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
            if (s == null) {
              return Center(
                child: Text('nothing'),
              );
            } else if (!s.hasData) {
              return Center(
                child: Text('nothing jo'),
              );
            } else {
              return Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(s.data.currentUser.displayName),
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
                      child: Text('logout'))
                ],
              );
            }
          }),
    );
  }
}

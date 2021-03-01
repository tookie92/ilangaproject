import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_router.dart';
import 'package:ilanga/blocs/bloc_welcome.dart';
import 'package:ilanga/services/services.dart';
import 'package:ilanga/ui/settings/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  final User user;

  WelcomePage(this.user);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocWelcome>(context);
    final size = MediaQuery.of(context).size;
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
                  elevation: 0.0,
                  backgroundColor: Palette.monNoir,
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
                body: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(color: Palette.monNoir),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: size.height / 3,
                      ),
                      Text(
                        'Bienvenue \n${s.data.currentUser.displayName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              elevation: 5,
                              shadowColor: Colors.purple[900],
                              backgroundColor: Palette.monGris,
                              onSurface: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)))),
                          onPressed: () {
                            Navigator.of(context)
                                .push(BlocRouter().crudityPage());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Create a tasks'.toUpperCase(),
                              style: TextStyle(fontSize: 15.0),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

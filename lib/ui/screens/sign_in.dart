import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_register.dart';
import 'package:ilanga/ui/forms/forms.dart';
import 'package:ilanga/ui/settings/palette.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocRegister>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Palette.monNoir),
        child: StreamBuilder<RegisterState>(
            stream: bloc.stream,
            builder: (context, s) {
              if (s == null) {
                return Center(child: Text('nothing to show'));
              } else if (!s.hasData) {
                return Center(child: Text('nothing wallah'));
              } else {
                return SigninForm();
              }
            }),
      ),
    );
  }
}

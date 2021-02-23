import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_router.dart';
import 'package:ilanga/services/services.dart';
import 'package:ilanga/ui/settings/palette.dart';
import 'package:ilanga/ui/widgets/text_field.dart';

class SigninForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final _formkey = GlobalKey<FormState>();

    return Column(
      children: [
        Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150.0,
                ),
                MyTextField(
                    textEditingController: _emailController,
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) =>
                        value.isEmpty ? "Please Enter was " : null),
                SizedBox(
                  height: 20.0,
                ),
                MyTextField(
                    textEditingController: _passwordController,
                    label: "Password",
                    obscureText: true,
                    validator: (value) =>
                        value.isEmpty ? "Please Enter was" : null)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              TextButton(
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();
                      print(_emailController.text);
                      print(_passwordController.text);
                      await DbFire().signin(_emailController.text,
                          _passwordController.text, context);
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Palette.interieur,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                  child: Text('Entrer')),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).push(BlocRouter().signUp());
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Palette.interieur,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                  child: Text('Register')),
            ],
          ),
        )
      ],
    );
  }
}

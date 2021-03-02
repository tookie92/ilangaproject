import 'package:flutter/material.dart';
import 'package:ilanga/services/services.dart';
import 'package:ilanga/ui/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
<<<<<<< HEAD
=======
    // User user;
>>>>>>> list
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
                    textEditingController: _nameController,
                    label: 'name',
                    validator: (value) => value.isEmpty ? 'No name' : null),
                SizedBox(
                  height: 20.0,
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
        TextButton(
            onPressed: () async {
              if (_formkey.currentState.validate()) {
                _formkey.currentState.save();
                //_formkey.currentState.reset();
                print(_emailController.text);
                print(_passwordController.text);
                print(_nameController.text);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('email', _emailController.text);
                prefs.setString('displayName', _nameController.text);
                await DbFire().signup(_emailController.text,
                    _passwordController.text, _nameController.text, context);
              }
            },
            child: Text('Entrer'))
      ],
    );
  }
}

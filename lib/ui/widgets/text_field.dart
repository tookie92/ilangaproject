import 'package:flutter/material.dart';
import 'package:ilanga/ui/settings/palette.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final Function validator;
  final bool obscureText;
  final TextInputType textInputType;

  MyTextField(
      {@required this.textEditingController,
      @required this.label,
      @required this.validator,
      this.obscureText = false,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Palette.interieur,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.deepPurpleAccent)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.2), width: 2.0)),
      ),
      validator: validator,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ilanga/ui/settings/palette.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final Function validator;
  final String initialValue;
  final Function onSaved;
  final bool obscureText;
  final TextInputType textInputType;

  MyTextField(
      {this.textEditingController,
      this.onSaved,
      @required this.label,
      @required this.validator,
      this.initialValue,
      this.obscureText = false,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      initialValue: initialValue,
      keyboardType: textInputType,
      onSaved: onSaved,
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

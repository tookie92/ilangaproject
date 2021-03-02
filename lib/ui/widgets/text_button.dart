import 'package:flutter/material.dart';
import 'package:ilanga/ui/settings/palette.dart';

class MyTextButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Color colorText;
  final double elevation;
  final Color shadowColor;
  final Color backgroundColor;

  MyTextButton(
      {@required this.onPressed,
      this.label,
      this.backgroundColor,
      this.colorText,
      this.elevation,
      this.shadowColor});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            primary: colorText,
            elevation: elevation,
            shadowColor: shadowColor,
            backgroundColor:
                backgroundColor == null ? Palette.monGris : backgroundColor,
            onSurface: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(7)))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 15.0),
          ),
        ));
  }
}

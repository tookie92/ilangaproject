import 'package:flutter/material.dart';
import 'package:ilanga/ui/settings/palette.dart';

class MyTextButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Color color;

  MyTextButton({@required this.onPressed, this.label, this.color});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            backgroundColor:
                color == null ? Palette.interieur : Colors.purple[900],
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(4.0))),
        child: Text(label));
  }
}

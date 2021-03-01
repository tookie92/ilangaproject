import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final Color color;
  final String label;
  final TextOverflow overflow;
  final double fontSize;
  final FontWeight fontWeight;

  MyText(
      {this.color, this.fontSize, this.label, this.fontWeight, this.overflow});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
    );
  }
}

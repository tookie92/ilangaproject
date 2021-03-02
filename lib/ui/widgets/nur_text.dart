import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final Color color;
  final String label;
  final TextOverflow overflow;
  final double fontSize;
  final FontWeight fontWeight;

  MyText(
      {this.color,
      this.fontSize,
      @required this.label,
      this.fontWeight,
      this.overflow});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      overflow: overflow,
      style: GoogleFonts.oswald(
        fontSize: fontSize,
        color: color == null ? Colors.white : color,
        fontWeight: fontWeight,
      ),
    );
  }
}

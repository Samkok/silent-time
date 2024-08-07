// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  final String text;
  final TextAlign alignText;
  int? maxLines;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final double? minFontSize;
  final bool ellipsisText;
  final double? lineHeight;
  final String? fontFamily;
  final TextDecoration? textDecoration;

  CText({
    Key? key,
    required this.text,
    this.color,
    required this.fontSize,
    this.alignText = TextAlign.start,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.ellipsisText = true,
    this.minFontSize,
    this.textDecoration,
    this.fontFamily,
    this.lineHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignText,
      maxLines: maxLines,
      // minFontSize: minFontSize ?? 8,
      overflow: ellipsisText ? TextOverflow.ellipsis : null,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Montserrat',
        height: lineHeight,
        decoration: textDecoration,
      ),
    );
  }
}

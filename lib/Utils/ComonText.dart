import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CommonTextWidget extends StatelessWidget {
  late var text = "";
  var fontWeight;
  double fontSize;
  var fontColor;
  var textAlignment;
  var height;
  var wordSpacing;
  var textDecoration;
  final int? maxLines;
  final TextOverflow? overflow;

  CommonTextWidget(
      {required this.text,
        this.fontWeight,
        required this.fontSize,
        this.fontColor,
        this.textAlignment,
        this.height,
        this.textDecoration,
        this.wordSpacing,
        this.maxLines,
        this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlignment,
        maxLines: maxLines,
        overflow:overflow,
        softWrap: true,
        style: TextStyle(
            height: height != null ? height : 1.3,
            wordSpacing: wordSpacing,
            color: fontColor,
            fontWeight: FontWeight. bold,
            decoration: textDecoration,
            fontSize: fontSize.toDouble()));
  }
}

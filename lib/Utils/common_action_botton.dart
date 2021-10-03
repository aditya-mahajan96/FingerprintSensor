import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ComonText.dart';

class CommonActionBottonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  var gradientStartColor;
  var gradientEndColor;
  var radius;
  var borderColor;
  var margin;
  var padding;
  var textColor;
  var fontWeight;
  var fontSize;
  bool isIcon;
  bool? isProgressShown;

  CommonActionBottonWidget(
      {required this.text,
      required this.onPressed,
      this.gradientStartColor,
      this.gradientEndColor,
      this.borderColor,
      this.radius,
      this.margin,
      this.padding,
      this.textColor,
      this.fontSize,
      required this.isIcon,
      this.fontWeight,
      this.isProgressShown});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: EdgeInsets.symmetric(horizontal: margin),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.13),
              blurRadius: 40,
              offset: Offset(0, 20))
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            gradientStartColor,
            gradientEndColor,
          ],
        ),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(
            vertical: padding),
        // color: gradientStartColor,
        splashColor: Colors.amber,
        child: Center(
          child:  CommonTextWidget(
                  text: text,
                  fontSize: fontSize,
                  fontColor: textColor,
                  fontWeight: fontWeight,
                  textAlignment: TextAlign.center,
                  height: 1.6,
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/font_family.dart';

class AppTexts {
  static Text titleText({
    required String text,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    double? letterSpacing,
  }) =>
      Text(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: TextStyle(
          color: color ?? AppColors.blackColor,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontFamily: FontFamily.poppin,
          fontSize: fontSize ?? 22,
          letterSpacing: letterSpacing,
        ),
      );

  static Text simpleText({
    required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? textDecoration,
    Color? decorationColor,
    double? letterSpacing,
  }) =>
      Text(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: TextStyle(
          fontSize: fontSize,
          color: color ?? AppColors.blackColor,
          fontWeight: fontWeight,
          fontFamily: FontFamily.poppin,
          decoration: textDecoration,
          decorationColor: decorationColor,
          letterSpacing: letterSpacing,
        ),
      );
}

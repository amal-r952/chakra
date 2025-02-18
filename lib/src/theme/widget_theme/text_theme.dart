import 'package:flutter/material.dart';

import '../../utils/font_family.dart';

TextTheme lightTextTheme = TextTheme(
  headlineLarge: TextStyle(
    color: Colors.black,
    fontFamily: FontFamily.gothamBold,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    color: Colors.black54,
    fontFamily: FontFamily.gothamBook,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  ),
  headlineSmall: TextStyle(
    color: Colors.black54,
    fontSize: 14,
    fontFamily: FontFamily.gothamBook,
    fontWeight: FontWeight.w100,
  ),
  bodyLarge: TextStyle(
    color: Colors.black,
    fontFamily: FontFamily.gothamBook,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    color: Colors.black54,
    fontSize: 12,
    fontFamily: FontFamily.gothamBook,
    fontWeight: FontWeight.w300,
  ),
  bodySmall: TextStyle(
    color: Colors.black26,
    fontFamily: FontFamily.gothamBook,
    fontSize: 11,
    fontWeight: FontWeight.w100,
  ),
  displayLarge: TextStyle(
      fontFamily: FontFamily.gothamBook,
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700),
  displaySmall: TextStyle(
      fontFamily: FontFamily.gothamBook,
      color: Colors.grey.shade600,
      fontSize: 11,
      fontWeight: FontWeight.w400),
  displayMedium: TextStyle(
      fontFamily: FontFamily.gothamBook,
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400),
);

TextTheme darkTextTheme = TextTheme(
  headlineLarge: TextStyle(
    fontFamily: FontFamily.gothamBold,
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    fontFamily: FontFamily.gothamBook,
    color: Colors.white54,
    fontSize: 15,
    fontWeight: FontWeight.w300,
  ),
  headlineSmall: TextStyle(
    color: Colors.white54,
    fontSize: 14,
    fontFamily: FontFamily.gothamBook,
    fontWeight: FontWeight.w100,
  ),
  bodyLarge: TextStyle(
    fontFamily: FontFamily.gothamBook,
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    color: Colors.white54,
    fontSize: 13,
    fontWeight: FontWeight.w300,
    fontFamily: FontFamily.gothamBook,
  ),
  bodySmall: TextStyle(
    fontFamily: FontFamily.gothamBook,
    color: Colors.white24,
    fontSize: 10,
    fontWeight: FontWeight.w100,
  ),
);

import 'package:flutter/material.dart';

class CustomFonts {
  const CustomFonts();

  static const TextStyle title = TextStyle(
      fontSize: 70,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Bebas-Neue');

  static const TextStyle subTitle = TextStyle(
      fontSize: 47,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Bebas-Neue');

  static const TextStyle subSubTitle = TextStyle(
      fontSize: 31,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Bebas-Neue');

  static const TextStyle button = TextStyle(
      fontSize: 18,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Bebas-Neue');

  static const TextStyle body1 = TextStyle(
      fontSize: 31,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Overpass');

  static const TextStyle body2 = TextStyle(
      fontSize: 21,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Overpass');
  static const TextStyle body3 = TextStyle(
      fontSize: 14,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Overpass');
  static const TextStyle body4 = TextStyle(
      fontSize: 11,
      height: 1.25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Overpass');
}

final customTextTheme = TextTheme(
  headline1: CustomFonts.title,
  headline2: CustomFonts.subTitle,
  headline3: CustomFonts.subSubTitle,
//  headline4: CustomFonts.headline4,
//  headline5: CustomFonts.headline5,
//  headline6: CustomFonts.headline6,
  subtitle1: CustomFonts.body1,
  subtitle2: CustomFonts.body2,
  bodyText1: CustomFonts.body3,
  bodyText2: CustomFonts.body4,
  button: CustomFonts.button,
);

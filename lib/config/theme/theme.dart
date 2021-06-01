import 'package:flutter/material.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/config/theme/fonts.dart';
import 'package:password_manager/constants/app_constants.dart';

ThemeData customTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: CustomColors.magicMint,
    textTheme: customTextTheme,
    colorScheme: customColorScheme,
    elevatedButtonTheme: customElevatedButtonTheme,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: CustomColors.magicMint),
    inputDecorationTheme: customInputTheme);

final customElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
  padding: MaterialStateProperty.all(EdgeInsets.all(AppConstants.sizes[0])),
  shape:
      MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppConstants.sizes[1]),
  )),
));

final customInputTheme = InputDecorationTheme(
    errorBorder: customInputBorder,
    focusedErrorBorder: customInputBorder,
    enabledBorder: customInputBorder,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    focusedBorder: customInputBorder,
    border: customInputBorder,
    contentPadding: EdgeInsets.all(AppConstants.sizes[1]));

final customInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(AppConstants.sizes[3]),
  ),
  borderSide: const BorderSide(color: CustomColors.magicMint, width: 2),
);

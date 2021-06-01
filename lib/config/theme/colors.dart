import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomColors {
  const CustomColors();
  static const richBlack = Color(0xFF02020A);
  static const magicMint = Color(0xFFA1E8CC);
  static const cultured = Color(0xFFF2F7F8);
}

final customColorScheme = ColorScheme(
    primary: CustomColors.magicMint,
    primaryVariant: CustomColors.magicMint,
    secondary: CustomColors.cultured,
    secondaryVariant: CustomColors.cultured,
    surface: CustomColors.richBlack,
    background: CustomColors.richBlack,
    error: CustomColors.magicMint,
    onPrimary: CustomColors.richBlack,
    onSecondary: CustomColors.richBlack,
    onSurface: CustomColors.cultured,
    onBackground: CustomColors.cultured,
    onError: CustomColors.richBlack,
    brightness: Brightness.dark);

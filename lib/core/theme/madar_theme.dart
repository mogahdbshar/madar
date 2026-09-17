import 'package:flutter/material.dart';

abstract final class MadarColors {
  static const emerald = Color(0xFF0B5D4B);
  static const emeraldDeep = Color(0xFF06382F);
  static const gold = Color(0xFFC7A45A);
  static const ivory = Color(0xFFF4F0E6);
  static const ink = Color(0xFF07110F);
  static const surfaceDark = Color(0xFF0D1715);
}

abstract final class MadarTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: MadarColors.emerald,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: MadarColors.ivory,
      fontFamily: 'MadarArabic',
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: MadarColors.emerald,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: MadarColors.ink,
      fontFamily: 'MadarArabic',
    );
  }
}

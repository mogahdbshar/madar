import 'package:flutter/material.dart';

abstract final class MadarColors {
  static const emerald = Color(0xFF0B5D4B);
  static const emeraldDeep = Color(0xFF06382F);
  static const gold = Color(0xFFC7A45A);
  static const ivory = Color(0xFFF4F0E6);
  static const ink = Color(0xFF07110F);
}

abstract final class MadarTheme {
  static ThemeData light() => _theme(Brightness.light, MadarColors.ivory);
  static ThemeData dark() => _theme(Brightness.dark, MadarColors.ink);
  static ThemeData _theme(Brightness brightness, Color background) {
    final scheme = ColorScheme.fromSeed(seedColor: MadarColors.emerald, brightness: brightness);
    return ThemeData(useMaterial3: true, colorScheme: scheme, scaffoldBackgroundColor: background, fontFamily: 'MadarArabic', navigationBarTheme: const NavigationBarThemeData(height: 72), cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24)))));
  }
}

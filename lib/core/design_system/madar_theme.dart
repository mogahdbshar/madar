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
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'MadarArabic',
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0, backgroundColor: Colors.transparent),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: background.withValues(alpha: .92),
        indicatorColor: MadarColors.gold.withValues(alpha: .18),
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
      ),
    );
  }
}

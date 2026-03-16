import 'package:flutter/material.dart';

class AppTheme {
  static const Color winColor = Color(0xFF64FFDA);
  // =========================
  // LIGHT THEME
  // =========================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 1, 143, 162), // for X
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 219, 23, 163), // for O
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white.withValues(alpha: 0.2),
      onSurface: Colors.white,
    ),
  );

  // =========================
  // DARK THEME
  // =========================
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF64D2FF), // for X
      onPrimary: Colors.white,
      secondary: Color(0xFFD670FF), // for O
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Color.fromARGB(255, 21, 27, 51).withValues(alpha: 0.4),
      onSurface: Colors.grey,
    ),
  );
}

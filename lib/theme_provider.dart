import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeStateNotifier =
    StateNotifierProvider<AppThemeNotifier, ThemeData>(
  (ref) => AppThemeNotifier(),
);

class AppThemeNotifier extends StateNotifier<ThemeData> {
  AppThemeNotifier() : super(_lightTheme);

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    cardColor: Colors.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: const Color(0xFF1E1E1E),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF121212),
      onSurface: Colors.white,
    ),
  );

  bool get isDarkMode => state.brightness == Brightness.dark;

  void toggleTheme() {
    state = isDarkMode ? _lightTheme : _darkTheme;
  }
}
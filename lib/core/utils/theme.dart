// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'styles.dart';

class AppTheme {
  // ================= Brand Colors =================

  static const Color primary = Color(0xFF001233);
  static const Color secondary = Color(0xFFE5B84A);

  static const Color white = Color(0xFFF8F8F5);

  // Dark Palette
  static const Color darkBackground = Color(0xFF000814);
  static const Color darkSurface = Color(0xFF000C18);
  static const Color darkCard = Color(0xFF00152B);

  static const Color inactiveGrey = Color(0xFF8C96A8);

  // ================= Light Theme =================

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    primaryColor: primary,
    scaffoldBackgroundColor: white,
    canvasColor: white,
    cardColor: Colors.white,
    dividerColor: const Color(0xFFE5E7EB),
    hintColor: Colors.black87,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
      selectedItemColor: primary,
      unselectedItemColor: inactiveGrey,
      showSelectedLabels: false,
      showUnselectedLabels: true,
      unselectedLabelStyle: Styles.textStyle400.copyWith(
        color: inactiveGrey,
        fontSize: 12,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  // ================= Dark Theme =================

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    primaryColor: primary,
    scaffoldBackgroundColor: darkBackground,
    canvasColor: darkBackground,
    cardColor: darkCard,
    dividerColor: const Color(0xFF1A2940),
    hintColor: Colors.white70,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: darkSurface,
      onSurface: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondary,
      foregroundColor: primary,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      elevation: 10,
      selectedItemColor: secondary,
      unselectedItemColor: inactiveGrey,
      showSelectedLabels: false,
      showUnselectedLabels: true,
      unselectedLabelStyle: Styles.textStyle400.copyWith(
        color: inactiveGrey,
        fontSize: 12,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: secondary,
        foregroundColor: primary,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}

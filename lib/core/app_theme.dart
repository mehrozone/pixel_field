import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xff0E1C20);
  static const Color bottomNavBarColor = Color(0xff0B1518);
  static const Color card = Color(0xFF122329);
  static const Color yellow = Color(0xFFE1A100);
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color black = Colors.black;
}

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.yellow,
    colorScheme: ColorScheme.light(
      surface: AppColors.background,
      primary: AppColors.yellow,
      secondary: AppColors.yellow,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 0,
        minimumSize: const Size.fromHeight(40),
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'EB Garamond',
        fontSize: 36,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'EB Garamond',
        fontSize: 32,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'EB Garamond',
        fontSize: 18,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'EB Garamond',
        fontSize: 16,
        color: AppColors.white,
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.yellow,
    colorScheme: ColorScheme.dark(
      surface: AppColors.background,
      primary: AppColors.yellow,
      secondary: AppColors.yellow,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 0,
        minimumSize: const Size.fromHeight(56),
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Headline',
        fontSize: 36,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Headline',
        fontSize: 32,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(fontSize: 18, color: AppColors.white),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.white),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:todoo/shared/styles/colors.dart';

class MyThemeData {
  static bool isDark = true;

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: mintGreen,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.shifting,
        backgroundColor: primary,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey),
  );

  static ThemeData darkTheme = ThemeData();
}

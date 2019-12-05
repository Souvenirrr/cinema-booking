import 'package:flutter/material.dart';

class ThemeMode {
  static String dark = 'dark';
  static String light = 'light';

  static String themseMode = dark;
}

class DarkMode {
  static Color backgroundColor = Color(0xff121212);
  static Color surfaceColor = Color(0xff212121);
  static Color primaryColor = Color(0xff332940);
  static Color secondaryColor = Color(0xffBB86FC);
  static Color onSurface = Color(0xffffff).withOpacity(0.87);
  static Color onBackground = Color(0xffffff).withOpacity(1);
}

class LightMode {
  static Color backgroundColor = Color(0xffffffff);
  static Color surfaceColor = Color(0xff212121);
  static Color primaryColor = Color(0xff332940);
  static Color onSurface = Color(0x000000).withOpacity(0.87);
  static Color onBackground = Color(0x000000).withOpacity(1);
}

class AppTheme {
  static Color backgroundColor = ThemeMode.themseMode == ThemeMode.dark
      ? DarkMode.backgroundColor
      : LightMode.backgroundColor;

  static Color surfaceColor = ThemeMode.themseMode == ThemeMode.dark
      ? DarkMode.surfaceColor
      : LightMode.surfaceColor;

  static Color primaryColor = ThemeMode.themseMode == ThemeMode.dark
      ? DarkMode.primaryColor
      : LightMode.primaryColor;

  static Color onSurface = ThemeMode.themseMode == ThemeMode.dark
      ? DarkMode.onSurface
      : LightMode.onSurface;

  static Color onBackground = ThemeMode.themseMode == ThemeMode.dark
      ? DarkMode.onBackground
      : LightMode.onBackground;
}

import 'package:flutter/material.dart';

import '../login_components/login_screens/login_screens_constants/const_var.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Colors.white, // cards, containers
    primary: Color(0xFFF5F5F5), // app background
    secondary: Color(0xFFE0E0E0), // subtle backgrounds/buttons
    tertiary: Color(0xFFBDBDBD), // outlines/dividers
    tertiaryFixed: Color(0xFF4A4A4A),
    inversePrimary: Colors.black, // text color (dark)
  ),
  scaffoldBackgroundColor: bgColor,
  appBarTheme: const AppBarTheme(color: bgColor, elevation: 0),
  splashColor: splashColor,
);

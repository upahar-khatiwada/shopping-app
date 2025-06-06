import 'package:flutter/material.dart';

import '../login_components/login_screens/login_screens_constants/const_var.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF121212), // cards, containers
    primary: Color(0xFF1E1E1E), // app background
    secondary: Color(0xFF2C2C2C), // subtle backgrounds/buttons
    tertiary: Color(0xFF424242),
    tertiaryFixed: Color(0xFF9F9F9F), // outlines/dividers
    inversePrimary: Colors.white, // text color (light)
  ),
  scaffoldBackgroundColor: bgColor,
  appBarTheme: const AppBarTheme(color: bgColor, elevation: 0),
  splashColor: splashColor,
);

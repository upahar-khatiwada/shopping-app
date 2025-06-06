import 'package:flutter/material.dart';

import '../login_components/login_screens/login_screens_constants/const_var.dart';

ThemeData lightMode = ThemeData(
  // colorScheme: ColorScheme.light(
  //   surface: Colors.grey.shade500,
  //   primary: const Color.fromARGB(255, 208, 207, 207),
  //   secondary: Colors.white38,
  //   tertiary: Colors.grey,
  //   inversePrimary: Colors.black87,
  // ),
  colorScheme: const ColorScheme.light(
    surface: Colors.white, // cards, containers
    primary: Color(0xFFF5F5F5), // app background
    secondary: Color(0xFFE0E0E0), // subtle backgrounds/buttons
    tertiary: Color(0xFFBDBDBD), // outlines/dividers
    inversePrimary: Colors.black, // text color (dark)
  ),
  scaffoldBackgroundColor: bgColor,
  appBarTheme: const AppBarTheme(color: bgColor, elevation: 0),
  splashColor: splashColor,
);

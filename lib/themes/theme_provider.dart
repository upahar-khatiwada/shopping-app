import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'light_mode.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider with ChangeNotifier {
  final Box<dynamic> themeBox = Hive.box('shopping_theme');

  // default theme is light theme
  ThemeData _themeData = lightMode;

  // constructor to read the saved theme from local device
  ThemeProvider() {
    final bool? isDark = themeBox.get('isDarkMode', defaultValue: false);

    // set the theme mode as per the theme read from the device
    _themeData = isDark! ? darkMode : lightMode;
  }

  // getter for theme data
  ThemeData get themeData => _themeData;

  // getter for dark mode for settings page
  bool get isDarkMode => _themeData == darkMode;

  // setter to set the theme data from toggleTheme() method
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    themeBox.put('isDarkMode', themeData == darkMode);
    notifyListeners();
  }

  // function to toggle the theme
  void toggleTheme() async {
    themeData = (_themeData == lightMode) ? darkMode : lightMode;
  }
}

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //_theme: keeps track of light mode and dark mode
  ThemeMode _theme = ThemeMode.dark;
  ThemeMode get theme => _theme;

  void toggleTheme() {
    final isDark = (_theme == ThemeMode.dark);
    _theme = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

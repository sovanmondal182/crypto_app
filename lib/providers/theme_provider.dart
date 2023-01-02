import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  // void setTheme(ThemeData theme) {
  //   themeData = theme;
  //   notifyListeners();
  // }

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // void getTheme() {
  //   themeData =
  //       themeData == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
  //   notifyListeners();
  // }
}

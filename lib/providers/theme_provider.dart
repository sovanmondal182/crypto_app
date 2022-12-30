import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData themeData;

  void setTheme(ThemeData theme) {
    themeData = theme;
    notifyListeners();
  }
}

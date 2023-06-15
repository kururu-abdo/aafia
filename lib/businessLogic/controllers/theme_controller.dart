import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  static bool _isDarkTheme = true;
ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
void loadTheme(){

  
}
void toggleTheme() {
  _isDarkTheme = !_isDarkTheme;
  notifyListeners();
}

}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  changeTheme(ThemeMode themeMode) async {
    appTheme = themeMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', appTheme == ThemeMode.dark);
    notifyListeners();
  }

  getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      if (isDark) {
        appTheme = ThemeMode.dark;
      } else {
        appTheme = ThemeMode.light;
      }
    }
    notifyListeners();
  }
}

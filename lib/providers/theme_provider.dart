import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      if (isDark == true) {
        appTheme = ThemeMode.dark;
      } else {
        appTheme = ThemeMode.light;
      }
      notifyListeners();
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    appTheme = themeMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', appTheme == ThemeMode.dark);
    notifyListeners();
  }
}

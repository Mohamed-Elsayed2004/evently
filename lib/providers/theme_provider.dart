import 'package:evently/services/shared_preference_services.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

   Future<void> loadTheme() async {
    final isDark = await SharedPreferenceServices.getDarkMode();

    currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    currentTheme = currentTheme == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();

    await SharedPreferenceServices.saveDarkMode(
      isDark: currentTheme == ThemeMode.dark,
    );
  }
}

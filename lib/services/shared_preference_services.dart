import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static const String language = 'language';
  static const String darkMode = 'darkMode';

  static Future<void> saveLanguage({required String lang}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(language, lang);
  }

  static Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentLanguage = prefs.getString(language) ?? 'en';
    return currentLanguage;
  }

  static Future<void> saveDarkMode({required bool isDark}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(darkMode, isDark);
  }

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkMode) ?? false;
  }
}

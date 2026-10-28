import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static const String language = 'language';

  static Future<void> saveLanguage({required String lang}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(language, lang);
  }

  static Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentLanguage = prefs.getString(language)??'en';
    return currentLanguage;
  }
}

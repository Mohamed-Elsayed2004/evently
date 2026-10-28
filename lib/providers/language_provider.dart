import 'package:evently/services/shared_preference_services.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  Future<void> loadLanguage() async {
    currentLanguage = await SharedPreferenceServices.getLanguage();

    notifyListeners();
  }

  Future<void> changeLanguage({required String language}) async {
    currentLanguage = language;
    notifyListeners();

    await SharedPreferenceServices.saveLanguage(lang: language);
  }
}

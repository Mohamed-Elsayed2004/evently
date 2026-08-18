import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  changLanguage() {
    currentLanguage = currentLanguage == 'en' ? 'ar' : 'en';
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  changLanguage({required String language}) {
    currentLanguage = language;
    notifyListeners();
  }
}

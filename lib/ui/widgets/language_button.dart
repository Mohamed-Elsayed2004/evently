import 'package:evently/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLanguage = context.watch<LanguageProvider>().currentLanguage;
    return InkWell(
      onTap: () {
        String language = currentLanguage == 'en' ? 'ar' : 'en';
        context.read<LanguageProvider>().changeLanguage(language: language);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),

        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          currentLanguage.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

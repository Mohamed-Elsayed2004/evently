

import 'package:evently/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LanguageBar extends StatefulWidget {
  const LanguageBar({super.key});

  @override
  State<LanguageBar> createState() => _LanguageBarState();
}

class _LanguageBarState extends State<LanguageBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          style: theme.textTheme.displayLarge,
          value: context.read<LanguageProvider>().currentLanguage,
          isExpanded: true,
          icon: SvgPicture.asset(
            'assets/svg/arrow-right.svg',
            colorFilter: ColorFilter.mode(
              theme.colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          items: const [
            DropdownMenuItem(value: "en", child: Text("English")),
            DropdownMenuItem(value: "ar", child: Text("العربية")),
          ],
          onChanged: (value) {
            context.read<LanguageProvider>().changLanguage(language: value!);
          },
        ),
      ),
    );
  }
}
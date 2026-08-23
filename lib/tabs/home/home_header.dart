import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/tabs/home/category_tab.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final List<EventType> categories;
  const HomeHeader({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.welcomeBack}✨',
                  style: AppTextStyle.font14SecText,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Moahemd Elsayed', style: AppTextStyle.headLine),
          ),
          TabBar(
            isScrollable: true,
            tabAlignment: .start,
            labelPadding: EdgeInsets.symmetric(horizontal: 10),
            tabs: [
              for (final category in categories)
                CategoryTab(category: category),
            ],
          ),
        ],
      ),
    );
  }
}

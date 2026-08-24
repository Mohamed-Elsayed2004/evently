import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/tabs/home/category_tab.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  final List<EventType> categories;
  const HomeHeader({super.key, required this.categories});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          SizedBox(height: 20),
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
          SizedBox(height: 24),
          TabBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            isScrollable: true,
            tabAlignment: .start,
            labelPadding: EdgeInsets.symmetric(horizontal: 10),
            indicator: const BoxDecoration(),
            dividerColor: Colors.transparent,
            splashBorderRadius: BorderRadius.circular(16),
            tabs: [
              for (int i = 0; i < widget.categories.length; i++)
                CategoryTab(
                  category: widget.categories[i],
                  isSelected: currentIndex == i,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/category_tab.dart';
import 'package:evently/ui/widgets/language_button.dart';
import 'package:evently/ui/widgets/theme_mode_button.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  final List<EventType> categories;
  final TabController controller;
  const HomeHeader({
    super.key,
    required this.categories,
    required this.controller,
  });

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
                Spacer(),
                ThemeModeButton(),
                SizedBox(width: 8),
                LanguageButton(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.watch<UserProvider>().user?.name ?? 'Waiting For Data...',
              style: AppTextStyle.headLine,
            ),
          ),
          SizedBox(height: 24),
          AnimatedBuilder(
            animation: controller.animation!,
            builder: (context, child) {
              return TabBar(
                onTap: (index) {
                  context.read<EventsProvider>().eventType =
                      categories[index].name;
                  context.read<EventsProvider>().streamEventsTrigger();
                },
                controller: controller,
                isScrollable: true,
                tabAlignment: .start,
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                indicator: const BoxDecoration(),
                dividerColor: Colors.transparent,
                splashBorderRadius: BorderRadius.circular(16),
                tabs: [
                  for (int i = 0; i < categories.length; i++)
                    CategoryTab(
                      category: categories[i],
                      isSelected: controller.animation!.value.round() == i,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

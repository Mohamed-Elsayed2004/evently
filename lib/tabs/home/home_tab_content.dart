import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/tabs/home/Event_list_view.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/firebase/events_firestore_service.dart';
import 'package:evently/utils/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent>
    with SingleTickerProviderStateMixin {
  final List<EventType> category = EventType.getEventType();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: category.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      //(_) => context.read<EventsProvider>().getEvents(),
      (_) {
        context.read<EventsProvider>().eventType = 'All';
        context.read<EventsProvider>().streamEventsTrigger();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().currentTheme;
    return DefaultTabController(
      length: category.length,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            HomeHeader(categories: category, controller: tabController),
            Expanded(
              child: context.watch<EventsProvider>().isLoading
                  ? Center(
                    child: CircularProgressIndicator(
                        color: themeMode == ThemeMode.light
                            ? AppColor.primaryLightMode
                            : AppColor.primaryDarkMode,
                      ),
                  )
                  : TabBarView(
                      controller: tabController,
                      children: [
                        /* if ()
                    ,*/
                        for (final cate in category)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: EventListView(
                              events: context.watch<EventsProvider>().events,
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

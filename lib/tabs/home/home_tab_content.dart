import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/tabs/home/Event_list_view.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/firebase/events_firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent>
    with SingleTickerProviderStateMixin {
  final List<EventType> category = EventType.getEventType();

  /*final List<Event> events = [
    Event(
      title: 'this is Event',
      description: 'I will meet ali in the schoole',
      imagePath: 'assets/images/Birthday_dark.png',
      dateTime: DateTime.now(),
      eventType: 'Birthday',
    ),
    Event(
      title: 'this is Event',
      description: 'I will meet ali in the schoole',
      imagePath: 'assets/images/Birthday_dark.png',
      dateTime: DateTime.now(),
      eventType: 'Birthday',
    ),
    Event(
      title: 'this is Event',
      description: 'I will meet ali in the schoole',
      imagePath: 'assets/images/Birthday_dark.png',
      dateTime: DateTime.now(),
      eventType: 'Birthday',
    ),
    Event(
      title: 'this is Event',
      description: 'I will meet ali in the schoole',
      imagePath: 'assets/images/Birthday_dark.png',
      dateTime: DateTime.now(),
      eventType: 'Birthday',
    ),
  ];*/
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: category.length, vsync: this);
    EventsFirestoreService.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: category.length,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            HomeHeader(categories: category, controller: tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  for (final cate in category)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: EventListView(events: []),
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

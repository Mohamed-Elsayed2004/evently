import 'package:evently/model/event_type.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:flutter/material.dart';

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  static final List<EventType> category = EventType.getEventType();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: category.length,
      child: SafeArea(
        bottom: false,
        child: Column(children: [HomeHeader(categories: category)]),
      ),
    );
  }
}

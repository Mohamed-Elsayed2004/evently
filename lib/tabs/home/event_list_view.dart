import 'package:evently/model/event.dart';
import 'package:evently/tabs/home/event_item.dart';
import 'package:flutter/material.dart';

class EventListView extends StatelessWidget {
  final List<Event> events;
  const EventListView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return EventItem(event: events[index]);
      },
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemCount: events.length,
    );
  }
}

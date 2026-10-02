import 'package:evently/firebase/events_firestore_service.dart';
import 'package:evently/model/event.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  List<Event> events = [];
  bool isLoading = false;
  String? errorMessage;

  List<Event> eventsForCategory({required String eventType}) {
    if (eventType == 'All') return events;
    return events.where((event) => event.eventType == eventType).toList();
  }

  Future<void> getEvents() async {
    try {
      isLoading = true;
      errorMessage = null;
      events = await EventsFirestoreService.getEvents();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}

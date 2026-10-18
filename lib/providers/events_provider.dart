import 'dart:math';

import 'package:evently/firebase/events_firestore_service.dart';
import 'package:evently/model/event.dart';
import 'package:evently/ui/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  List<Event> events = [];
  bool isLoading = false;
  String eventType = '';
  String? errorMessage;
  List<Event> favoriteEvents = [];

  /* List<Event> eventsForCategory({required String eventType}) {
    if (eventType == 'All') return events;
    return events.where((event) => event.eventType == eventType).toList();
  }*/

  Future<void> getEvents() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      events = await EventsFirestoreService.getEvents();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> toggleFavorite({required Event event}) async {
    isLoading = true;
    notifyListeners();
    event.isFavourite = !event.isFavourite;
    await EventsFirestoreService.updateEvent(event: event);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getFavoriteEventsTrigger() async {
    favoriteEvents = await EventsFirestoreService.getFavoriteEvents();
    notifyListeners();
  }

  streamEventsTrigger() {
    EventsFirestoreService.streamEvents(eventType: eventType).listen((
      eventList,
    ) {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      events = eventList;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> deleteEventTrigger({required String eventID}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      await EventsFirestoreService.deleteEvent(eventID: eventID);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

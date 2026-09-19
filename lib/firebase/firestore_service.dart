import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';
import 'package:evently/utils/app_firestore_collections.dart';

class FirestoreService {
  static final eventRef = FirebaseFirestore.instance
      .collection(AppFirestoreCollections.events)
      .withConverter<Event>(
        fromFirestore: (snapshot, _) => Event.fromJson(snapshot.data()!),
        toFirestore: (event, _) => event.toJson(),
      );

  static addEvent() async {
    await eventRef.add(
      Event(
        title: 'game play',
        description: 'football game',
        imagePath: 'assets/images/Sport.png',
        dateTime: DateTime.now(),
        eventType: 'sport',
      ),
    );
    log('event added');
  }

  static Future<List<Event>> getEvents() async {
    QuerySnapshot<Event> quarySnabshot = await eventRef.get();
    return quarySnabshot.docs.map<Event>((doc) => doc.data()).toList();
  }
}

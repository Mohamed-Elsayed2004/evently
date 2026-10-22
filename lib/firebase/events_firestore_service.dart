import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase/users_firestore_service.dart';
import 'package:evently/model/event.dart';
import 'package:evently/utils/app_firestore_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventsFirestoreService {
  static CollectionReference<Event> eventsCollection(String uid) {
    return UsersFirestoreService.userRef
        .doc(uid)
        .collection(AppFirestoreCollections.events)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  static Future<void> addEvent({required Event event}) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = eventsCollection(uid).doc();
    event.id = docRef.id;
    await docRef.set(event);
    log('event added');
  }

  static Future<List<Event>> getEvents() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Event> quarySnabshot = await eventsCollection(uid).get();
    return quarySnabshot.docs.map<Event>((doc) => doc.data()).toList();
  }

  static Future<void> updateEvent({required Event event}) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    await eventsCollection(uid).doc(event.id).update(event.toJson());
  }

  static Future<List<Event>> getFavoriteEvents() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Event> quarySnabshot = await eventsCollection(
      uid,
    ).where('isFavourite', isEqualTo: true).orderBy('dateTime').get();
    return quarySnabshot.docs.map<Event>((doc) => doc.data()).toList();
  }

  static Stream<List<Event>> streamEvents({required String eventType}) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    Query<Event> query = eventsCollection(uid);

    if (eventType != 'All') {
      query = query.where('eventType', isEqualTo: eventType);
    }

    return query.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  static Future<void> deleteEvent({required String eventID}) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    await eventsCollection(uid).doc(eventID).delete();
  }
}

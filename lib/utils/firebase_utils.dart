import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';
import 'package:evently/utils/app_firestore_collections.dart';

class FirebaseUtils {
  static final eventRef = FirebaseFirestore.instance
      .collection(AppFirestoreCollections.events)
      .withConverter<Event>(
        fromFirestore: (snapshot, _) => Event.fromJson(snapshot.data),
        toFirestore: (event, _) => event.toJson(),
      );

  static addEvent() async {
    await eventRef.add(
      Event(
        title: 'kora',
        description: 'football game',
        imagePath: 'assets/images/Sport.png',
        dateTime: DateTime.now(),
        eventType: 'sport',
      ),
    );
  }
}

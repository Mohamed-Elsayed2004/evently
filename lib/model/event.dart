import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Event {
  String? id;
  String title;
  String description;
  String imagePath;
  String imagePathDark;
  DateTime dateTime;
  String eventType;
  bool isFavourite;

  Event({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.dateTime,
    required this.eventType,
    this.isFavourite = false,
    this.id ,
    required this.imagePathDark,
  });

  factory Event.fromJson(Map<String, dynamic> data) {
    return Event(
      title: data['title'],
      description: data['description'],
      imagePath: data['imagePath'],
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      eventType: data['eventType'],
      isFavourite: data['isFavourite'],
      id: data['id'],
      imagePathDark: data['imagePathDark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'imagePathDark': imagePathDark,
      'dateTime': Timestamp.fromDate(dateTime),
      'eventType': eventType,
      'isFavourite': isFavourite,
      'id': id,
    };
  }
}

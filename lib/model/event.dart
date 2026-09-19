import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Event {
  String title;
  String description;
  String imagePath;
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
  });

  factory Event.fromJson(Map<String, dynamic> data) {
    return Event(
      title: data['title'],
      description: data['description'],
      imagePath: data['imagePath'],
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      eventType: data['eventType'],
      isFavourite: data['isFavourite']
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'title':title,
      'description':description,
      'imagePath':imagePath,
      'dateTime':Timestamp.fromDate(dateTime),
      'eventType':eventType,
      'isFavourite':isFavourite
    };
  }
}

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
}

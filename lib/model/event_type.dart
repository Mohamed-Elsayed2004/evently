import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventType {
  final FaIconData icon;
  final String name;
  final String imagePathLight;
  final String imagePathDark;
  EventType({
    required this.icon,
    required this.name,
    required this.imagePathLight,
    required this.imagePathDark,
  });

  static List<EventType> getEventType() {
    return [
      EventType(
        icon: FontAwesomeIcons.tableCellsLarge,
        name: 'All',
        imagePathLight: '',
        imagePathDark: '',
      ),
      EventType(
        icon: FontAwesomeIcons.personBiking,
        name: 'Sport',
        imagePathLight: 'assets/images/Sport-1.png',
        imagePathDark: 'assets/images/Sport.png',
      ),
      EventType(
        icon: FontAwesomeIcons.cakeCandles,
        name: 'Birthday',
        imagePathLight: 'assets/images/Birthday_light.png',
        imagePathDark: 'assets/images/Birthday_dark.png',
      ),
      EventType(
        icon: FontAwesomeIcons.bookOpen,
        name: 'BookClub',
        imagePathLight: 'assets/images/Book Club_light.png',
        imagePathDark: 'assets/images/Book Club_dark.png',
      ),
      EventType(
        icon: FontAwesomeIcons.peopleGroup,
        name: 'Meeting',
        imagePathLight: 'assets/images/Meeting-1.png',
        imagePathDark: 'assets/images/Meeting.png',
      ),
      EventType(
        icon: FontAwesomeIcons.images,
        name: 'Exhibition',
        imagePathLight: 'assets/images/Exhibition-1.png',
        imagePathDark: 'assets/images/Exhibition.png',
      ),
    ];
  }
}

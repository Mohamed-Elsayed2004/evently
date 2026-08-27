import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final eventTypes = EventType.getEventType().sublist(1);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.add_event)),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(children: [EventTypeSelector(events: eventTypes)]),
      ),
    );
  }
}

class EventTypeSelector extends StatefulWidget {
  final List<EventType> events;
  const EventTypeSelector({super.key, required this.events});

  @override
  State<EventTypeSelector> createState() => _EventTypeSelectorState();
}

class _EventTypeSelectorState extends State<EventTypeSelector> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final themeMode = context.read<ThemeProvider>().currentTheme;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16),

          child: Image.asset(
            themeMode == ThemeMode.dark
                ? widget.events[selectedIndex].imagePathDark
                : widget.events[selectedIndex].imagePathLight,
          ),
        ),
      ],
    );
  }
}

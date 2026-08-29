import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        child: Column(
          spacing: 16,
          children: [
            EventTypeSelector(events: eventTypes),
            Text('Title',style:AppTextStyle.font16SecText ,),
            CustomTextFormField(labelText: 'Event Title'),
          ],
        ),
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
        SizedBox(height: 16),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .05,
          child: ListView.separated(
            scrollDirection: .horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => setState(() {
                  selectedIndex = index;
                }),
                child: EventTypeTab(
                  event: widget.events[index],
                  isSelected: selectedIndex == index,
                ),
              );
            },
            separatorBuilder: (_, _) => SizedBox(width: 8),
            itemCount: widget.events.length,
          ),
        ),
      ],
    );
  }
}

class EventTypeTab extends StatelessWidget {
  final EventType event;
  final bool isSelected;
  const EventTypeTab({super.key, required this.event, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? theme.colorScheme.primary : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          FaIcon(
            event.icon,
            color: isSelected ? Colors.white : theme.colorScheme.primary,
          ),
          Text(
            event.name,
            style: TextStyle(
              color: isSelected ? Colors.white : theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/date_and_time_field.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/assets.dart';
import 'package:evently/firebase/events_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DateTime? selectedDate;
  String? formatedDate;
  String? formatedTime;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final eventTypes = EventType.getEventType().sublist(1);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.add_event)),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              EventTypeSelector(events: eventTypes),
              SizedBox(height: 8),
              Text('Title', style: AppTextStyle.font16Text),
              CustomTextFormField(labelText: 'Event Title'),
              Text('Description ', style: AppTextStyle.font16Text),
              CustomTextFormField(
                labelText: 'Event Description....',
                maxLines: 5,
              ),
              DateAndTimeField(
                label: 'Event Date',
                svgIcon: Assets.calendarSVG,
                chooseText: formatedDate == null
                    ? 'Choose date'
                    : formatedDate!,
                onTap: () {
                  chooseDate();
                },
              ),
              DateAndTimeField(
                label: 'Event Time',
                svgIcon: Assets.clockSVG,
                chooseText: formatedTime == null
                    ? 'Choose time'
                    : formatedTime!,
                onTap: () {
                  chooseTime();
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .02),
              CustomButton(
                onTap: () {
                  EventsFirestoreService.addEvent();
                },
                text: 'Add event',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.now(),
    );
    selectedDate = chooseDate;
    setState(() {
      formatedDate = selectedDate == null
          ? null
          : DateFormat('MMM d, y').format(selectedDate!);
    });
  }

  Future<void> chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      formatedTime = chooseTime?.format(context);
    });
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

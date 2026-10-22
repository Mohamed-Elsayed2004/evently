import 'package:evently/firebase/events_firestore_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_back_button.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/date_and_time_field.dart';
import 'package:evently/ui/widgets/show_snack_bar.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddAndEditEventScreen extends StatefulWidget {
  const AddAndEditEventScreen({super.key});

  @override
  State<AddAndEditEventScreen> createState() => _AddAndEditEventScreenState();
}

class _AddAndEditEventScreenState extends State<AddAndEditEventScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? formatedDate;
  String? formatedTime;
  String? title;
  String? description;
  String imagePath = '';
  String imagePathDark = '';
  String eventType = '';
  Event? eventForUpdate;
  bool isInitialized = false;
  late final ThemeMode themeMode;
  late final ThemeData theme;
  late final AppLocalizations l10n;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      l10n = AppLocalizations.of(context)!;
      theme = Theme.of(context);
      themeMode = context.read<ThemeProvider>().currentTheme;
      isInitialized = true;
      eventForUpdate = ModalRoute.of(context)?.settings.arguments as Event?;
      if (eventForUpdate != null) {
        title = eventForUpdate!.title;
        description = eventForUpdate!.description;
        imagePath = eventForUpdate!.imagePath;
        imagePathDark = eventForUpdate!.imagePathDark;
        eventType = eventForUpdate!.eventType;

        selectedDate = eventForUpdate!.dateTime;
        selectedTime = TimeOfDay.fromDateTime(eventForUpdate!.dateTime);

        formatedDate = DateFormat('MMM d, y').format(eventForUpdate!.dateTime);
        formatedTime = selectedTime!.format(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventTypes = EventType.getEventType().sublist(1);
    return ModalProgressHUD(
      inAsyncCall: context.watch<EventsProvider>().isLoading,
      progressIndicator: CircularProgressIndicator(
        color: themeMode == ThemeMode.light
            ? AppColor.primaryLightMode
            : AppColor.primaryDarkMode,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(eventForUpdate == null ? l10n.add_event : l10n.editEvent),
          leading: const CustomBackButton(),
          leadingWidth: 40,
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  SizedBox(height: 8),
                  EventTypeSelector(
                    events: eventTypes,
                    eventForUpdate: eventForUpdate,
                    onEventSelected: (index) {
                      setState(() {
                        eventType = eventTypes[index].name;
                        imagePath = eventTypes[index].imagePathLight;
                        imagePathDark = eventTypes[index].imagePathDark;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  Text(l10n.title, style: AppTextStyle.font16Text),
                  CustomTextFormField(
                    initialValue: title,
                    labelText: l10n.eventTitle,
                    onChange: (data) => title = data,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter event title';
                      }

                      if (value.trim().length < 3) {
                        return 'Title must be at least 3 characters';
                      }

                      if (value.trim().length > 100) {
                        return 'Title must not exceed 100 characters';
                      }

                      return null;
                    },
                  ),
                  Text(l10n.description, style: AppTextStyle.font16Text),
                  CustomTextFormField(
                    initialValue: description,
                    labelText: l10n.eventDescription,
                    maxLines: 5,
                    onChange: (data) => description = data,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter event description';
                      }

                      if (value.trim().length < 10) {
                        return 'Description must be at least 10 characters';
                      }

                      return null;
                    },
                  ),
                  DateAndTimeField(
                    label: l10n.eventDate,
                    svgIcon: Assets.calendarSVG,
                    chooseText: formatedDate == null
                        ? l10n.chooseDate
                        : formatedDate!,
                    onTap: () {
                      chooseDate();
                    },
                  ),
                  DateAndTimeField(
                    label: l10n.eventTime,
                    svgIcon: Assets.clockSVG,
                    chooseText: formatedTime == null
                        ? l10n.chooseTime
                        : formatedTime!,
                    onTap: () {
                      chooseTime();
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                  CustomButton(
                    onTap: () async {
                      if (!formKey.currentState!.validate()) return;

                      if (selectedDate == null || selectedTime == null) {
                        showSnackBar(context, l10n.selectDateAndTime);
                        return;
                      }

                      final event = Event(
                        id: eventForUpdate?.id,
                        title: title!,
                        description: description!,
                        imagePath: imagePath,
                        imagePathDark: imagePathDark,
                        dateTime: DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        ),
                        eventType: eventType,
                      );

                      final provider = context.read<EventsProvider>();

                      if (eventForUpdate == null) {
                        await provider.addEvent(event: event);
                      } else {
                        await provider.updateEvent(event: event);
                      }

                      if (!context.mounted) return;

                      if (provider.errorMessage != null) {
                        showSnackBar(context, provider.errorMessage!);
                        return;
                      }
                      provider.eventDetailsUpdate(event: event);
                      Navigator.of(context).pop();
                    },
                    text: eventForUpdate == null
                        ? l10n.add_event
                        : l10n.editEvent,
                  ),
                ],
              ),
            ),
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
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (chooseDate == null) return;
    setState(() {
      selectedDate = chooseDate;
      formatedDate = DateFormat('MMM d, y').format(selectedDate!);
    });
  }

  Future<void> chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (chooseTime == null) return;

    setState(() {
      selectedTime = chooseTime;
      formatedTime = chooseTime.format(context);
    });
  }
}

class EventTypeSelector extends StatefulWidget {
  final List<EventType> events;
  final Event? eventForUpdate;
  final void Function(int index) onEventSelected;
  const EventTypeSelector({
    super.key,
    required this.events,
    required this.onEventSelected,
    this.eventForUpdate,
  });

  @override
  State<EventTypeSelector> createState() => _EventTypeSelectorState();
}

class _EventTypeSelectorState extends State<EventTypeSelector> {
  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.eventForUpdate == null
        ? 0
        : widget.events.indexWhere(
            (eventType) => eventType.name == widget.eventForUpdate!.eventType,
          );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.read<ThemeProvider>().currentTheme;
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(16),
            border: BoxBorder.all(color: theme.colorScheme.outline),
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),

            child: Image.asset(
              themeMode == ThemeMode.dark
                  ? widget.events[selectedIndex].imagePathDark
                  : widget.events[selectedIndex].imagePathLight,
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .05,
          child: ListView.separated(
            scrollDirection: .horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onEventSelected(index);
                },
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

/*Event(
                              title: title!,
                              description: description!,
                              imagePath: imagePath,
                              imagePathDark: imagePathDark,
                              dateTime: DateTime(
                                selectedDate!.year,
                                selectedDate!.month,
                                selectedDate!.day,
                                selectedTime!.hour,
                                selectedTime!.minute,
                              ),
                              eventType: eventType,
                            ), */

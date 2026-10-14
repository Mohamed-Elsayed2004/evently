import 'package:evently/firebase/events_firestore_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/event_type.dart';
import 'package:evently/providers/theme_provider.dart';
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

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? formatedDate;
  String? formatedTime;
  String title = '';
  String description = '';
  String imagePath = '';
  String imagePathDark = '';
  String eventType = '';
  late final ThemeMode themeMode;
  late final ThemeData theme;
  late final AppLocalizations l10n;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeMode = context.watch<ThemeProvider>().currentTheme;
    theme = Theme.of(context);

    l10n = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    final eventTypes = EventType.getEventType().sublist(1);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(
        color: themeMode == ThemeMode.light
            ? AppColor.primaryLightMode
            : AppColor.primaryDarkMode,
      ),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.add_event)),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  EventTypeSelector(
                    events: eventTypes,
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
                      if (formKey.currentState!.validate()) {
                        if (selectedDate == null || selectedTime == null) {
                          showSnackBar(context, l10n.selectDateAndTime);
                          return;
                        }
                        try {
                          setState(() {
                            isLoading = true;
                          });

                          await EventsFirestoreService.addEvent(
                            event: Event(
                              title: title,
                              description: description,
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
                            ),
                          );
                          if (context.mounted) Navigator.of(context).pop();
                        } catch (e) {
                          if (context.mounted) {
                            showSnackBar(context, e.toString());
                          }
                        } finally {
                          if (mounted) setState(() => isLoading = false);
                        }
                      }
                    },
                    text: l10n.addEvent,
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
    selectedTime = chooseTime;
    setState(() {
      formatedTime = chooseTime?.format(context);
    });
  }
}

class EventTypeSelector extends StatefulWidget {
  final List<EventType> events;
  final void Function(int index) onEventSelected;
  const EventTypeSelector({
    super.key,
    required this.events,
    required this.onEventSelected,
  });

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

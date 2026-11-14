import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_back_button.dart';
import 'package:evently/ui/widgets/show_snack_bar.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final themeMode = context.read<ThemeProvider>().currentTheme;
    Event event = context.watch<EventsProvider>().eventDetails;
    final provider = context.read<EventsProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        leadingWidth: 40,
        centerTitle: true,
        title: Text(l10n.eventDetails),
        actions: [
          CustomActionButton(
            imagePath: Assets.editSvg,
            color: theme.colorScheme.primary,
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.addEventScreen, arguments: event);
            },
          ),
          CustomActionButton(
            imagePath: Assets.trashSvg,
            color: theme.colorScheme.error,
            onTap: () async {
              await provider.deleteEventTrigger(eventID: event.id!);
              if (!context.mounted) return;
              if (provider.errorMessage == null) {
                await provider.getFavoriteEventsTrigger();
                if (context.mounted) Navigator.of(context).pop();
              } else {
                if (context.mounted) {
                  showSnackBar(context, provider.errorMessage!);
                }
              }
            },
          ),
        ],
      ),
      body: context.watch<EventsProvider>().isLoading
          ? CircularProgressIndicator(
              color: themeMode == ThemeMode.light
                  ? AppColor.primaryLightMode
                  : AppColor.primaryDarkMode,
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 16,
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
                              ? event.imagePathDark
                              : event.imagePath,
                        ),
                      ),
                    ),
                    Text(event.title, style: AppTextStyle.font18TextW500),
                    DateTimeCard(
                      theme: theme,
                      themeMode: themeMode,
                      event: event,
                    ),
                    Text(l10n.description, style: AppTextStyle.font16Text),
                    Container(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: 100,
                      ),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colorScheme.outline),
                        color: theme.colorScheme.surfaceContainer,
                      ),
                      child: Text(event.description),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    super.key,
    required this.theme,
    required this.themeMode,
    required this.event,
  });

  final ThemeData theme;
  final ThemeMode themeMode;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
        side: BorderSide(color: theme.colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
              color: themeMode == ThemeMode.light
                  ? AppColor.backgroundLightMode
                  : AppColor.inputDarkMode,
            ),
            child: SvgPicture.asset(
              Assets.calendarSVG,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          title: Text(
            DateFormat('dd MMMM').format(event.dateTime),
            style: AppTextStyle.font16Text.copyWith(
              color: themeMode == ThemeMode.light
                  ? AppColor.mainTextLightMode
                  : AppColor.primaryDarkMode,
            ),
          ),
          subtitle: Text(
            DateFormat('hh:mm a').format(event.dateTime),
            style: AppTextStyle.font16Text.copyWith(
              color: themeMode == ThemeMode.light
                  ? AppColor.disable
                  : AppColor.secTextDarkMode,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomActionButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final String imagePath;
  const CustomActionButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      radius: 10,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: SvgPicture.asset(
          imagePath,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}

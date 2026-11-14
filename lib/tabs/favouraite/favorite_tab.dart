import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/tabs/home/Event_list_view.dart';
import 'package:evently/ui/widgets/custom_svg_pic.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late AppLocalizations l10n;
  List<Event> filterList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = AppLocalizations.of(context)!;
    filterList = context.watch<EventsProvider>().favoriteEvents;
  }

  void onChangeSearch(String text) {
    final events = context.read<EventsProvider>().favoriteEvents;
    setState(() {
      filterList = events.where((event) {
        return event.title.contains(text);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            CustomTextFormField(
              labelText: l10n.searchForEvent,
              suffixIcon: SvgPicture.asset(
                Assets.searchSvg,
                fit: BoxFit.none,
                width: 24,
                height: 24,
              ),
              onChange: onChangeSearch,
            ),
            Expanded(child: EventListView(events: filterList)),
          ],
        ),
      ),
    );
  }
}

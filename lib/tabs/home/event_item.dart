import 'package:evently/model/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 203,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
        image: event.imagePath.isEmpty
            ? null
            : DecorationImage(
                image: AssetImage(event.imagePath),
                fit: BoxFit.cover,
              ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          DateBadge(theme: theme, event: event),
          Spacer(),
          TitleBar(theme: theme, event: event),
        ],
      ),
    );
  }
}

class TitleBar extends StatefulWidget {
  const TitleBar({super.key, required this.theme, required this.event});

  final ThemeData theme;
  final Event event;

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.theme.scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            widget.event.title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              setState(() {
                widget.event.isFavourite = !widget.event.isFavourite;
              });
            },
            child: Icon(
              widget.event.isFavourite ? Icons.favorite : Icons.favorite_border,
              color: widget.theme.colorScheme.primary,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class DateBadge extends StatelessWidget {
  const DateBadge({super.key, required this.theme, required this.event});

  final ThemeData theme;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        DateFormat('dd MMM').format(event.dateTime),
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight(600),
          fontSize: 16,
        ),
      ),
    );
  }
}

import 'package:evently/model/event_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryTab extends StatelessWidget {
  final EventType category;
  final bool isSelected;
  const CategoryTab({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.outline;
    final backgroundColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.onPrimary;
    return Tab(
      height: 40,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? backgroundColor : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          spacing: 8,
          children: [
            FaIcon(
              category.icon,
              color: isSelected ? Colors.white : backgroundColor,
            ),
            Text(
              category.name,
              style: TextStyle(color: isSelected ? Colors.white : textColor),
            ),
          ],
        ),
      ),
    );
  }
}

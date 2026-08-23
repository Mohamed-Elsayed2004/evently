

import 'package:evently/model/event_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryTab extends StatelessWidget {
  final EventType category;
  const CategoryTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        child:Row(
          spacing: 8,
          children: [
          FaIcon(category.icon),
          Text(category.name)
        ],) ,
      ),
    );
  }
}
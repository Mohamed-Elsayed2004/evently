import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          padding: EdgeInsets.all(9),
          backgroundColor: theme.colorScheme.primary,
        ),
        child: Text(
          text,
          style: AppTextStyle.font20Text.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

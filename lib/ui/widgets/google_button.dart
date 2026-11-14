import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const GoogleButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
            side: BorderSide(color: theme.colorScheme.outline),
          ),
          padding: EdgeInsets.all(11),
          backgroundColor: theme.colorScheme.surfaceContainer,
        ),
        child: Row(
          spacing: 16,
          mainAxisAlignment: .center,
          children: [
            Image.asset(Assets.googleLogo, width: 24, height: 24),
            Text(
              text,
              style: AppTextStyle.font18TextW500.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

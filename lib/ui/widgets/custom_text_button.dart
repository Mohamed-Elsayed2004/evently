import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomTextButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

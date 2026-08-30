import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateAndTimeField extends StatelessWidget {
  final String label;
  final String svgIcon;
  final String chooseText;
  final VoidCallback onTap;
  const DateAndTimeField({
    super.key,
    required this.label,
    required this.svgIcon,
    required this.chooseText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SvgPicture.asset(
          svgIcon,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: 4),
        Text(label, style: AppTextStyle.font16Text),
        Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            chooseText,
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

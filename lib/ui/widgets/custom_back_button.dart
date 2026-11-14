import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = context.watch<ThemeProvider>().currentTheme;
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 32,
        height: 32,
        margin: const EdgeInsetsDirectional.only(start: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Transform.flip(
          flipX: Directionality.of(context) == TextDirection.rtl,
          child: SvgPicture.asset(
            Assets.arrowLeftSvg,
            width: 10,
            height: 10,
            colorFilter: ColorFilter.mode(
              themeMode == ThemeMode.light
                  ? AppColor.primaryLightMode
                  : AppColor.inputLightMode,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_svg_pic.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<ThemeProvider>().currentTheme;
    return InkWell(
      onTap: () => context.read<ThemeProvider>().toggleTheme(),
      child: SizedBox(
        width: 24,
        height: 24,
        child: currentTheme == ThemeMode.light
            ? CustomSvgPicture(svgPath: Assets.sunSvg)
            : CustomSvgPicture(svgPath: Assets.moonSvg),
      ),
    );
  }
}

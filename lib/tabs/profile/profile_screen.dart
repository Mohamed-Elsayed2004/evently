import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/tabs/profile/language_bar.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 20,
            children: [
              SizedBox(height: 12),
              ProfilePicture(),
              Text(
                'Mohamed elsayed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Text(
                'mohamedelsayed2004@gmail.com',
                maxLines: 2,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              SettingWidget(
                label: AppLocalizations.of(context)!.darkMode,
                onTap: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
                trailing: Switch(
                  value:
                      context.watch<ThemeProvider>().currentTheme ==
                      ThemeMode.dark,
                  onChanged: (_) {
                    context.read<ThemeProvider>().toggleTheme();
                  },
                ),
              ),
              LanguageBar(),
              SettingWidget(
                label: 'Logout',
                trailing: SvgPicture.asset('assets/svg/logout-02.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      height: 124,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1000),
          topRight: Radius.circular(1000),
          bottomLeft: Radius.circular(1000),
          bottomRight: Radius.circular(1000),
        ),
      ),
    );
  }
}

class SettingWidget extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final Widget trailing;
  const SettingWidget({
    super.key,
    required this.label,
    this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(label, style: AppTextStyle.headLine),

            Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}




